import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VocesFluidezApp());
}

class VocesFluidezApp extends StatefulWidget {
  const VocesFluidezApp({Key? key}) : super(key: key);

  @override
  State<VocesFluidezApp> createState() => _VocesFluidezAppState();
}

class _VocesFluidezAppState extends State<VocesFluidezApp> {
  bool isDarkMode = false;
  bool isHighContrast = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void toggleHighContrast() {
    setState(() {
      isHighContrast = !isHighContrast;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme;
    if (isHighContrast) {
      theme = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        cardColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.yellow,
          secondary: Colors.cyan,
          surface: Colors.black,
        ),
      );
    } else {
      theme = isDarkMode
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            );
    }

    return MaterialApp(
      title: 'VocesFluidez AAC',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: MainAACScreen(
        onToggleTheme: toggleTheme,
        onToggleContrast: toggleHighContrast,
        isHighContrast: isHighContrast,
      ),
    );
  }
}

class WordItem {
  final String text;
  final String source;
  final IconData? icon;
  final Color? color;

  WordItem({required this.text, required this.source, this.icon, this.color});
}

class ChatMessage {
  final String sender; // 'user' or 'interlocutor'
  final String text;
  final String time;

  ChatMessage({required this.sender, required this.text, required this.time});
}

class VocabularyData {
  static final List<Map<String, dynamic>> coreVocabulary = [
    {'id': 'yo', 'text': 'Yo', 'color': Colors.blue, 'icon': Icons.person},
    {
      'id': 'quiero',
      'text': 'Quiero',
      'color': Colors.green,
      'icon': Icons.volunteer_activism,
    },
    {
      'id': 'no-quiero',
      'text': 'No quiero',
      'color': Colors.red,
      'icon': Icons.block,
    },
    {
      'id': 'me-gusta',
      'text': 'Me gusta',
      'color': Colors.amber,
      'icon': Icons.thumb_up,
    },
    {
      'id': 'necesito',
      'text': 'Necesito',
      'color': Colors.indigo,
      'icon': Icons.front_hand,
    },
    {
      'id': 'siento',
      'text': 'Me siento',
      'color': Colors.teal,
      'icon': Icons.favorite,
    },
    {
      'id': 'donde',
      'text': 'Dónde',
      'color': Colors.purple,
      'icon': Icons.location_on,
    },
    {
      'id': 'cuando',
      'text': 'Cuándo',
      'color': Colors.purple,
      'icon': Icons.access_time,
    },
    {
      'id': 'por-que',
      'text': 'Por qué',
      'color': Colors.purple,
      'icon': Icons.help,
    },
    {
      'id': 'gracias',
      'text': 'Gracias',
      'color': Colors.cyan,
      'icon': Icons.handshake,
    },
    {
      'id': 'ayuda',
      'text': 'Ayuda',
      'color': Colors.redAccent,
      'icon': Icons.warning,
    },
    {
      'id': 'si',
      'text': 'Sí',
      'color': Colors.lightGreen,
      'icon': Icons.check_circle,
    },
    {'id': 'no', 'text': 'No', 'color': Colors.blueGrey, 'icon': Icons.cancel},
    {
      'id': 'tal-vez',
      'text': 'Tal vez',
      'color': Colors.grey,
      'icon': Icons.shuffle,
    },
    {
      'id': 'no-se',
      'text': 'No sé',
      'color': Colors.grey,
      'icon': Icons.question_mark,
    },
    {
      'id': 'mas',
      'text': 'Más',
      'color': Color(0xFF059669),
      'icon': Icons.add_circle,
    },
  ];

  static final Map<String, List<Map<String, dynamic>>> fringeVocabulary = {
    'Saludos': [
      {'text': '¡Hola! Buenos días', 'icon': Icons.wb_sunny},
      {'text': '¡Buenas tardes!', 'icon': Icons.wb_twilight},
      {'text': '¡Buenas noches!', 'icon': Icons.bedtime},
      {'text': '¡Hola! Qué gusto verte', 'icon': Icons.waving_hand},
      {'text': '¿Cómo has estado?', 'icon': Icons.sentiment_satisfied},
      {'text': '¡Hasta luego!', 'icon': Icons.exit_to_app},
      {'text': 'Nos vemos pronto', 'icon': Icons.history},
      {'text': 'Cuídate mucho', 'icon': Icons.health_and_safety},
    ],
    'Familia': [
      {'text': 'tu familia', 'icon': Icons.groups},
      {'text': 'tus hijos', 'icon': Icons.child_care},
      {'text': 'mis nietos', 'icon': Icons.face},
      {'text': 'mi mamá', 'icon': Icons.woman},
      {'text': 'mi papá', 'icon': Icons.man},
      {'text': 'los abuelitos', 'icon': Icons.elderly},
      {'text': 'mis amigos', 'icon': Icons.group},
      {'text': 'mi cuidador/a', 'icon': Icons.medical_services},
    ],
    'Deportes': [
      {'text': 'el partido de fútbol', 'icon': Icons.sports_soccer},
      {'text': 'el baloncesto', 'icon': Icons.sports_basketball},
      {'text': 'el campeonato', 'icon': Icons.emoji_events},
      {'text': 'mi equipo favorito', 'icon': Icons.shield},
      {'text': '¿quién va ganando?', 'icon': Icons.leaderboard},
      {'text': 'hacer ejercicios / kine', 'icon': Icons.fitness_center},
    ],
    'Lugares': [
      {'text': 'la casa', 'icon': Icons.home},
      {'text': 'el jardín / patio', 'icon': Icons.park},
      {'text': 'el hospital / clínica', 'icon': Icons.local_hospital},
      {'text': 'la farmacia', 'icon': Icons.local_pharmacy},
      {'text': 'el supermercado', 'icon': Icons.shopping_cart},
      {'text': 'la cocina', 'icon': Icons.kitchen},
      {'text': 'el dormitorio / cama', 'icon': Icons.bed},
    ],
    'Personas': [
      {'text': 'el doctor / médica', 'icon': Icons.badge},
      {'text': 'el kinesiólogo/a', 'icon': Icons.accessible},
      {'text': 'el enfermero/a', 'icon': Icons.local_hospital},
      {'text': 'mi amigo/a', 'icon': Icons.person_add},
      {'text': 'el vecino/a', 'icon': Icons.house_siding},
    ],
    'Clima': [
      {'text': 'hace mucho frío', 'icon': Icons.ac_unit},
      {'text': 'hace calor hoy', 'icon': Icons.thermostat},
      {'text': 'está lloviendo', 'icon': Icons.water_drop},
      {'text': 'está muy lindo el día', 'icon': Icons.wb_sunny},
      {'text': 'está nublado', 'icon': Icons.cloud},
    ],
  };

  static final List<String> grammarConnectors = [
    'y',
    'porque',
    'pero',
    'para',
    'con',
    'en el / la',
    'que',
    'también',
    'ahora',
    'después',
  ];

  static final List<String> questionStarters = [
    '¿Cómo está',
    '¿Cómo van',
    '¿Qué tal',
    '¿Dónde queda',
    '¿Cuándo es el / la',
    '¿Viste el / la',
    '¿Vamos a ir a',
  ];
}

class MainAACScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final VoidCallback onToggleContrast;
  final bool isHighContrast;

  const MainAACScreen({
    Key? key,
    required this.onToggleTheme,
    required this.onToggleContrast,
    required this.isHighContrast,
  }) : super(key: key);

  @override
  State<MainAACScreen> createState() => _MainAACScreenState();
}

class _MainAACScreenState extends State<MainAACScreen>
    with SingleTickerProviderStateMixin {
  late FlutterTts flutterTts;
  late TabController _tabController;

  List<WordItem> constructedSentence = [];
  int touchCount = 0;
  String conversationContext = '';
  String activeCategory = 'Saludos';
  String _typedText = '';

  double speechRate = 0.5; // FlutterTTS rate ranges 0.0 - 3.0
  double speechPitch = 1.0;
  List<Map<String, String>> availableVoices = [];
  Map<String, String>? selectedVoiceMap;

  List<ChatMessage> chatLog = [
    ChatMessage(
      sender: 'interlocutor',
      text: '¡Hola! ¿Cómo estás hoy?',
      time: '10:00 AM',
    ),
  ];
  List<String> favorites = [
    "¡Hola! Buenos días, ¿cómo estás?",
    "¿Cómo está la familia?",
    "Dame un momento, estoy armando mi respuesta.",
  ];

  List<String> humorPhrases = [
    "¡Váyanse a la mierda!",
    "¡Chúpalo entonces!",
    "¡Está helado Juan!",
    "¡Ya po, avívate!",
    "¡Qué buena po!",
    "¡Ándate a la chucha!",
    "¡Toy cansado de escuchar leseras!",
    "¡Tómate un armonil!",
  ];

  final TextEditingController _contextController = TextEditingController();
  final TextEditingController _customPhraseController = TextEditingController();
  final TextEditingController _humorPhraseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _initTTS();
    _loadStoredFavorites();
    _loadStoredHumor();
  }

  void _loadStoredHumor() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? stored = prefs.getStringList('aac_humor_phrases');
    if (stored != null) {
      setState(() {
        humorPhrases = stored;
      });
    }
  }

  void _saveHumor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('aac_humor_phrases', humorPhrases);
  }

  void _addHumorPhrase(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      humorPhrases.add(text.trim());
    });
    _saveHumor();
  }

  void _deleteHumorPhrase(int index) {
    setState(() {
      humorPhrases.removeAt(index);
    });
    _saveHumor();
  }

  void _initTTS() async {
    flutterTts = FlutterTts();
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setPitch(speechPitch);

    try {
      var voicesResult = await flutterTts.getVoices;
      if (voicesResult != null) {
        List<Map<String, String>> loaded = [];
        for (var v in voicesResult) {
          if (v is Map) {
            String name = v["name"]?.toString() ?? "";
            String locale = v["locale"]?.toString() ?? "";
            if (locale.toLowerCase().contains("es") ||
                name.toLowerCase().contains("spanish") ||
                name.toLowerCase().contains("es-")) {
              loaded.add({"name": name, "locale": locale});
            }
          }
        }
        setState(() {
          availableVoices = loaded;
          if (availableVoices.isNotEmpty) {
            selectedVoiceMap = availableVoices.first;
          }
        });
      }
    } catch (e) {
      debugPrint("Error al cargar voces: $e");
    }
  }

  void _loadStoredFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? stored = prefs.getStringList('aac_favorites');
    if (stored != null) {
      setState(() {
        favorites = stored;
      });
    }
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('aac_favorites', favorites);
  }

  void _addWordToSentence(String text, String source) {
    setState(() {
      constructedSentence.add(WordItem(text: text, source: source));
      touchCount++;
    });
  }

  void _removeLastWord() {
    if (constructedSentence.isNotEmpty) {
      setState(() {
        constructedSentence.removeLast();
      });
    }
  }

  void _clearSentence() {
    setState(() {
      constructedSentence.clear();
      touchCount = 0;
    });
  }

  void _speakText(String text) async {
    if (text.trim().isEmpty) return;
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setPitch(speechPitch);
    if (selectedVoiceMap != null) {
      await flutterTts.setVoice(selectedVoiceMap!);
    }
    await flutterTts.speak(text);
  }

  void _speakCurrentSentence() {
    final sentence = constructedSentence.map((e) => e.text).join(' ');
    if (sentence.isNotEmpty) {
      _speakText(sentence);
      _sendToChatLog('user', sentence);
      _clearSentence();
    }
  }

  void _sendToChatLog(String sender, String text) {
    final timeStr =
        "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
    setState(() {
      chatLog.add(ChatMessage(sender: sender, text: text, time: timeStr));
    });
  }

  List<String> _getPredictions() {
    final currentText = constructedSentence
        .map((e) => e.text)
        .join(' ')
        .toLowerCase();

    if (currentText.contains('¿cómo está') ||
        currentText.contains('¿cómo van')) {
      return ['tu familia', 'tus hijos', 'el trabajo', 'el clima afuera'];
    } else if (currentText.contains('¿dónde queda') ||
        currentText.contains('ir a')) {
      return [
        'el jardín',
        'el parque',
        'la farmacia',
        'la cocina',
        'el hospital',
      ];
    } else if (currentText.contains('viste') ||
        currentText.contains('partido')) {
      return ['el partido de fútbol', 'las noticias del día', 'el campeonato'];
    } else if (currentText.endsWith('quiero') ||
        currentText.endsWith('necesito')) {
      return [
        'ir a la casa',
        'descansar un rato',
        'tomar remedios',
        'ver el partido',
      ];
    } else if (currentText.endsWith('me gusta')) {
      return [
        'el partido de fútbol',
        'la música',
        'esta comida rica',
        'platicar contigo',
      ];
    }

    return [
      '¡Hola! Buenos días',
      '¿Cómo está la familia?',
      'Yo quiero',
      'Hace mucho frío',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final sentenceText = constructedSentence.map((e) => e.text).join(' ');
    final totalLetters = sentenceText.length;
    final savedPct = totalLetters > 0 && touchCount > 0
        ? (((totalLetters - touchCount) / totalLetters) * 100)
              .clamp(0, 100)
              .round()
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.record_voice_over, color: Colors.blueAccent),
            SizedBox(width: 8),
            Text(
              'VocesFluidez AAC',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.psychology),
            tooltip: "Dame un momento...",
            onPressed: () =>
                _speakText("Dame un momento, estoy armando mi respuesta."),
          ),
          IconButton(
            icon: const Icon(Icons.contrast),
            onPressed: widget.onToggleContrast,
            tooltip: "Alto Contraste",
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettingsDialog,
            tooltip: "Ajustes de Voz",
          ),
        ],
      ),
      body: Column(
        children: [
          // DIALOGUE CONTEXT HEADER
          Container(
            color: Colors.indigo.shade900,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                const Icon(Icons.forum, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _contextController,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: "Contexto / ¿De qué están hablando?",
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 12),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onSubmitted: (val) {
                      setState(() {
                        conversationContext = val;
                      });
                      _sendToChatLog('interlocutor', val);
                    },
                  ),
                ),
              ],
            ),
          ),

          // SENTENCE DISPLAY CONTAINER
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
            ),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(minHeight: 50),
                  width: double.infinity,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (constructedSentence.isEmpty)
                        Text(
                          "Toca palabras abajo para construir tu frase...",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      else
                        ...constructedSentence.map(
                          (item) => Chip(
                            label: Text(
                              item.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.blue.shade700,
                            onDeleted: () {
                              setState(() {
                                constructedSentence.remove(item);
                              });
                            },
                            deleteIconColor: Colors.white70,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (savedPct > 0)
                      Text(
                        "Ahorro motor: $savedPct% ($touchCount toques vs $totalLetters letras)",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: _speakCurrentSentence,
                      icon: const Icon(Icons.volume_up, color: Colors.white),
                      label: const Text(
                        "HABLAR",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      icon: const Icon(Icons.backspace, color: Colors.amber),
                      onPressed: _removeLastWord,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: _clearSentence,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // CONNECTORS & STARTERS STRIP
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 4,
                  runSpacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      "Preguntar: ",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    ...VocabularyData.questionStarters.map(
                      (starter) => ActionChip(
                        label: Text(
                          starter,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.amber.shade100,
                        onPressed: () => _addWordToSentence(starter, 'starter'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      "Conectores: ",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    ...VocabularyData.grammarConnectors.map(
                      (connector) => ActionChip(
                        label: Text(
                          connector,
                          style: const TextStyle(fontSize: 11),
                        ),
                        onPressed: () =>
                            _addWordToSentence(connector, 'grammar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // PREDICTIVE SUGGESTIONS BAR
          Container(
            height: 42,
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: _getPredictions()
                  .map(
                    (pred) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: InputChip(
                        avatar: const Icon(
                          Icons.auto_awesome,
                          size: 14,
                          color: Colors.blue,
                        ),
                        label: Text(
                          pred,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () => _addWordToSentence(pred, 'prediction'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          // MAIN SPLIT INTERFACE (Core Vocabulary Grid + Tabs)
          Expanded(
            child: Row(
              children: [
                // LEFT COLUMN: CORE VOCABULARY GRID (Fixed positions)
                Expanded(
                  flex: 6,
                  child: Card(
                    margin: const EdgeInsets.all(6),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "VOCABULARIO NÚCLEO (Fijo)",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1.1,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                  ),
                              itemCount: VocabularyData.coreVocabulary.length,
                              itemBuilder: (context, index) {
                                final item =
                                    VocabularyData.coreVocabulary[index];
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: item['color'] as Color,
                                    padding: const EdgeInsets.all(4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () =>
                                      _addWordToSentence(item['text'], 'core'),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        item['icon'] as IconData,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item['text'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // RIGHT COLUMN: TABBED FRINGE & CHAT LOG
                Expanded(
                  flex: 5,
                  child: Card(
                    margin: const EdgeInsets.all(6),
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          tabs: const [
                            Tab(text: "Temas"),
                            Tab(text: "Social"),
                            Tab(text: "Diálogo"),
                            Tab(text: "Teclado"),
                            Tab(text: "Favoritas"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // TAB 1: CATEGORIES & FRINGE
                              _buildFringeTab(),
                              // TAB 2: QUICK SOCIAL EXPRESSIONS
                              _buildSocialTab(),
                              // TAB 3: CHAT DIALOGUE LOG
                              _buildChatLogTab(),
                              // TAB 4: LARGE ACCESSIBLE KEYBOARD
                              _buildLargeKeyboardTab(),
                              // TAB 5: FAVORITES
                              _buildFavoritesTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFringeTab() {
    final categories = VocabularyData.fringeVocabulary.keys.toList();
    final items = VocabularyData.fringeVocabulary[activeCategory] ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "CATEGORÍAS TEMÁTICAS:",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 4),
          // Categories with Wrap
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: categories.map((cat) {
              final isSelected = cat == activeCategory;
              return ChoiceChip(
                label: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                selectedColor: Colors.blue.shade200,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      activeCategory = cat;
                    });
                  }
                },
              );
            }).toList(),
          ),
          const Divider(height: 12),
          const Text(
            "SUB-ELEMENTOS DE CONVERSACIÓN:",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          // Subcategory items wrapped so they wrap downwards cleanly
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: items.map((item) {
              return OutlinedButton.icon(
                onPressed: () =>
                    _addWordToSentence(item['text'] as String, 'fringe'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  item['icon'] as IconData,
                  size: 18,
                  color: Colors.blue,
                ),
                label: Text(
                  item['text'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeKeyboardTab() {
    final rows = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'Ñ'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Á', 'É', 'Í', 'Ó', 'Ú'],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          // Textbox displaying currently typed word
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue, width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _typedText.isEmpty
                        ? "Toca las letras para escribir..."
                        : _typedText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _typedText.isEmpty ? Colors.grey : null,
                    ),
                  ),
                ),
                if (_typedText.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _addWordToSentence(_typedText.trim(), 'keyboard');
                      setState(() {
                        _typedText = '';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                    ),
                    child: const Text(
                      "Añadir",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // High Contrast Large Keys
          ...rows.map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 4,
                runSpacing: 4,
                children: row.map((char) {
                  return SizedBox(
                    width: 34,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _typedText += char.toLowerCase();
                        });
                      },
                      child: Text(
                        char,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Control keys: Backspace and Space / Insert
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                    ),
                    onPressed: () {
                      if (_typedText.isNotEmpty) {
                        setState(() {
                          _typedText = _typedText.substring(
                            0,
                            _typedText.length - 1,
                          );
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.backspace,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      "Borrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                    onPressed: () {
                      if (_typedText.isNotEmpty) {
                        _addWordToSentence(_typedText.trim(), 'keyboard');
                        setState(() {
                          _typedText = '';
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.space_bar,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      "Espacio / Añadir",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialTab() {
    final socialPhrases = [
      "¡Hola! Buenos días, ¿cómo estás?",
      "Muchas gracias por acompañarme hoy.",
      "¿Cómo está la familia?",
      "¿Pudiste ver el partido de fútbol?",
      "Dame un momento, estoy armando mi respuesta.",
      "Cuéntame más sobre ese tema.",
    ];

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        const Text(
          "EXPRESIONES SOCIALES RÁPIDAS:",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 4),
        ...socialPhrases.map(
          (phrase) => Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 6),
            child: ListTile(
              dense: true,
              title: Text(
                phrase,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              trailing: const Icon(Icons.volume_up, color: Colors.green),
              onTap: () {
                _speakText(phrase);
                _sendToChatLog('user', phrase);
              },
            ),
          ),
        ),
        const Divider(height: 16, thickness: 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Text(
                  "HUMOR Y MODISMOS CHILENOS ",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                Text("🇨🇱", style: TextStyle(fontSize: 12)),
              ],
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
              onPressed: _openAddHumorDialog,
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              label: const Text(
                "Agregar",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ...humorPhrases.asMap().entries.map((entry) {
          final idx = entry.key;
          final phrase = entry.value;
          return Card(
            elevation: 1,
            color: Colors.red.shade50,
            margin: const EdgeInsets.only(bottom: 6),
            child: ListTile(
              dense: true,
              title: Text(
                phrase,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.red.shade900,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Colors.green),
                    onPressed: () {
                      _speakText(phrase);
                      _sendToChatLog('user', phrase);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: () => _deleteHumorPhrase(idx),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  void _openAddHumorDialog() {
    _humorPhraseController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Agregar Frase de Humor / Modismo 🇨🇱",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: _humorPhraseController,
            decoration: const InputDecoration(
              hintText: "Ej. ¡Chúpalo entonces! / ¡Qué buena po!",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                _addHumorPhrase(_humorPhraseController.text);
                Navigator.pop(context);
              },
              child: const Text(
                "Guardar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChatLogTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: chatLog.length,
            itemBuilder: (context, idx) {
              final msg = chatLog[idx];
              final isUser = msg.sender == 'user';
              return Align(
                alignment: isUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg.text,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        msg.time,
                        style: TextStyle(
                          color: isUser ? Colors.white70 : Colors.black54,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: favorites.length,
      itemBuilder: (context, idx) {
        final fav = favorites[idx];
        return ListTile(
          dense: true,
          title: Text(
            fav,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.volume_up, color: Colors.green),
            onPressed: () => _speakText(fav),
          ),
        );
      },
    );
  }

  void _openSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Ajustes de Sintetizador de Voz"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Velocidad de voz: ${speechRate.toStringAsFixed(1)}x"),
                    Slider(
                      value: speechRate.clamp(0.1, 3.0),
                      min: 0.1,
                      max: 3.0,
                      divisions: 29,
                      onChanged: (val) {
                        setDialogState(() {
                          speechRate = val;
                        });
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                    Text("Tono de voz: ${speechPitch.toStringAsFixed(1)}"),
                    Slider(
                      value: speechPitch.clamp(0.5, 2.0),
                      min: 0.5,
                      max: 2.0,
                      divisions: 15,
                      onChanged: (val) {
                        setDialogState(() {
                          speechPitch = val;
                        });
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 12),
                    if (availableVoices.isNotEmpty) ...[
                      const Text(
                        "Seleccionar Voz (Español):",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      DropdownButton<Map<String, String>>(
                        isExpanded: true,
                        value: selectedVoiceMap,
                        items: availableVoices.map((v) {
                          final name = v["name"] ?? "Voz";
                          final isMale =
                              name.toLowerCase().contains("male") ||
                              name.toLowerCase().contains("jorge") ||
                              name.toLowerCase().contains("diego") ||
                              name.toLowerCase().contains("hombre") ||
                              name.toLowerCase().contains("carlos");
                          return DropdownMenuItem<Map<String, String>>(
                            value: v,
                            child: Text(
                              "${v["name"]} (${v["locale"]})${isMale ? ' 👨' : ' 👩'}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setDialogState(() {
                              selectedVoiceMap = val;
                            });
                            setState(() {});
                            flutterTts.setVoice(val);
                          }
                        },
                      ),
                    ] else
                      const Text(
                        "Voces adicionales disponibles según el motor TTS de tu dispositivo.",
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Aceptar"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
