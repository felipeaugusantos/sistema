object frmConfiguraConsultaEdicao: TfrmConfiguraConsultaEdicao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Configura'#231#227'o da Consulta'
  ClientHeight = 623
  ClientWidth = 1034
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 595
    Width = 1034
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      1034
      28)
    object btnGravar: TBitBtnLocked
      Left = 4
      Top = 4
      Width = 72
      Height = 20
      Caption = '&Gravar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 1
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCancela: TBitBtnLocked
      Left = 957
      Top = 4
      Width = 72
      Height = 20
      Anchors = [akTop, akRight]
      Caption = '&Cancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pgcPesquisa: TPageControl
    Left = 0
    Top = 0
    Width = 1034
    Height = 595
    ActivePage = tbsGerais
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tbsGerais: TTabSheet
      Caption = '&Configura'#231#245'es Gerais'
      object Panel4: TPanel
        Left = 0
        Top = 231
        Width = 1026
        Height = 333
        Align = alClient
        Caption = 'Panel4'
        TabOrder = 1
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 518
          Height = 331
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object cxgColunas: TcxGrid
            Left = 0
            Top = 0
            Width = 518
            Height = 283
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgColunasView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsColunas
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.Deleting = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = ' '
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              object cxgColunasEXIBIR: TcxGridDBColumn
                Caption = 'Exibir'
                DataBinding.FieldName = 'EXIBIR'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                Properties.OnChange = cxgColunasEXIBIRPropertiesChange
                HeaderAlignmentHorz = taCenter
                Width = 58
              end
              object cxgColunasPESQUI: TcxGridDBColumn
                Caption = 'Pesquisar'
                DataBinding.FieldName = 'PESQUI'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Properties.OnChange = cxgColunasPESQUIPropertiesChange
                HeaderAlignmentHorz = taCenter
                Width = 61
              end
              object cxgColunasCONTID: TcxGridDBColumn
                Caption = 'Contida'
                DataBinding.FieldName = 'CONTID'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 57
              end
              object cxgColunasAUTSEL: TcxGridDBColumn
                Caption = 'Auto-Sele'#231#227'o'
                DataBinding.FieldName = 'AUTSEL'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 76
              end
              object cxgColunasDESCAM: TcxGridDBColumn
                Caption = 'Coluna'
                DataBinding.FieldName = 'DESCAM'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 270
              end
              object cxgColunasNOMCAM: TcxGridDBColumn
                DataBinding.FieldName = 'NOMCAM'
                Visible = False
                Options.Editing = False
              end
            end
            object cxgColunasLevel1: TcxGridLevel
              GridView = cxgColunasView
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 283
            Width = 518
            Height = 48
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object btnMarcaTodos: TBitBtnLocked
              Left = 21
              Top = 12
              Width = 154
              Height = 22
              Caption = '[ F6 ] Marca Exibir Todos'
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
                555555555555555555555555555555555555555555FF55555555555559055555
                55555555577FF5555555555599905555555555557777F5555555555599905555
                555555557777FF5555555559999905555555555777777F555555559999990555
                5555557777777FF5555557990599905555555777757777F55555790555599055
                55557775555777FF5555555555599905555555555557777F5555555555559905
                555555555555777FF5555555555559905555555555555777FF55555555555579
                05555555555555777FF5555555555557905555555555555777FF555555555555
                5990555555555555577755555555555555555555555555555555}
              NumGlyphs = 2
              TabOrder = 0
              OnClick = btnMarcaTodosClick
            end
            object btnDesmarcaTodos: TBitBtnLocked
              Left = 181
              Top = 12
              Width = 166
              Height = 22
              Caption = '[ F7 ] Desmarca Exibir Todos'
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000130B0000130B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
                3333333777333777FF3333993333339993333377FF3333377FF3399993333339
                993337777FF3333377F3393999333333993337F777FF333337FF993399933333
                399377F3777FF333377F993339993333399377F33777FF33377F993333999333
                399377F333777FF3377F993333399933399377F3333777FF377F993333339993
                399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
                99333773FF3333777733339993333339933333773FFFFFF77333333999999999
                3333333777333777333333333999993333333333377777333333}
              NumGlyphs = 2
              TabOrder = 1
              OnClick = btnDesmarcaTodosClick
            end
          end
        end
        object Panel1: TPanel
          Left = 519
          Top = 1
          Width = 506
          Height = 331
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object pnlUpDown: TPanel
            Left = 0
            Top = 283
            Width = 506
            Height = 48
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object btnUp: TSpeedButton
              Left = 118
              Top = 12
              Width = 23
              Height = 22
              Hint = 'Sobe a Coluna'
              Flat = True
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
                3333333333777F33333333333309033333333333337F7F333333333333090333
                33333333337F7F33333333333309033333333333337F7F333333333333090333
                33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
                3333333777737777F333333099999990333333373F3333373333333309999903
                333333337F33337F33333333099999033333333373F333733333333330999033
                3333333337F337F3333333333099903333333333373F37333333333333090333
                33333333337F7F33333333333309033333333333337373333333333333303333
                333333333337F333333333333330333333333333333733333333}
              NumGlyphs = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = btnUpClick
            end
            object btnDown: TSpeedButton
              Left = 142
              Top = 12
              Width = 23
              Height = 22
              Hint = 'Desce a Coluna'
              Flat = True
              Glyph.Data = {
                76010000424D7601000000000000760000002800000020000000100000000100
                04000000000000010000120B0000120B00001000000000000000000000000000
                800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
                333333333337F33333333333333033333333333333373F333333333333090333
                33333333337F7F33333333333309033333333333337373F33333333330999033
                3333333337F337F33333333330999033333333333733373F3333333309999903
                333333337F33337F33333333099999033333333373333373F333333099999990
                33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
                33333333337F7F33333333333309033333333333337F7F333333333333090333
                33333333337F7F33333333333309033333333333337F7F333333333333090333
                33333333337F7F33333333333300033333333333337773333333}
              NumGlyphs = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = btnDownClick
            end
          end
          object cxgSelecionadas: TcxGrid
            Left = 0
            Top = 0
            Width = 506
            Height = 283
            Align = alClient
            TabOrder = 1
            OnEnter = cxgSelecionadasEnter
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgSelecionadasView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsColSel
              DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.Deleting = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = ' '
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              object cxgSelecionadasORDCAM: TcxGridDBColumn
                Caption = 'Ordem'
                DataBinding.FieldName = 'ORDCAM'
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Options.Editing = False
                Options.Sorting = False
                Width = 41
              end
              object cxgSelecionadasDESCAM: TcxGridDBColumn
                Caption = 'Coluna para Pesquisa'
                DataBinding.FieldName = 'DESCAM'
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Options.Sorting = False
                Width = 188
              end
              object cxgSelecionadasNOMCAM: TcxGridDBColumn
                DataBinding.FieldName = 'NOMCAM'
                Visible = False
                Options.Editing = False
              end
              object cxgSelecionadasCOMZER: TcxGridDBColumn
                Caption = 'Completar com Zeros'
                DataBinding.FieldName = 'COMZER'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                OnCustomDrawCell = cxgSelecionadasCOMZERCustomDrawCell
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Options.Sorting = False
                Width = 68
              end
              object cxgSelecionadasPERIOD: TcxGridDBColumn
                Caption = 'Pedir Per'#237'odo'
                DataBinding.FieldName = 'PERIOD'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                Properties.OnChange = cxgSelecionadasPERIODPropertiesChange
                HeaderAlignmentHorz = taCenter
                Width = 51
              end
              object cxgSelecionadasOBRIGA: TcxGridDBColumn
                Caption = 'Individual. Obrigat'#243'rio'
                DataBinding.FieldName = 'OBRIGA'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 65
              end
              object cxgSelecionadasQTDCAR: TcxGridDBColumn
                Caption = 'Qtd. M'#237'm. Caracteres'
                DataBinding.FieldName = 'QTDCAR'
                OnCustomDrawCell = cxgSelecionadasQTDCARCustomDrawCell
                HeaderAlignmentHorz = taCenter
                Width = 66
              end
              object cxgSelecionadasGRUOBR: TcxGridDBColumn
                Caption = 'Grupo Obrigat'#243'rio'
                DataBinding.FieldName = 'GRUOBR'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 65
              end
              object cxgSelecionadasTIPDAD: TcxGridDBColumn
                DataBinding.FieldName = 'TIPDAD'
                Visible = False
              end
            end
            object cxgSelecionadasLevel1: TcxGridLevel
              GridView = cxgSelecionadasView
            end
          end
        end
      end
      object pnlKey: TPanel
        Left = 0
        Top = 0
        Width = 1026
        Height = 205
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object rdgTipPes: TRadioGroup
          Left = 16
          Top = 0
          Width = 375
          Height = 51
          Caption = 'Tipo de Pesquisa'
          ItemIndex = 1
          Items.Strings = (
            'Parcial Key (Pesquisa a cada caracter digitado)'
            'Complete Key (Espera o <RETURN> para pesquisar)')
          TabOrder = 0
          OnClick = rdgTipPesClick
        end
        object GroupBox1: TGroupBox
          Left = 16
          Top = 88
          Width = 753
          Height = 113
          Caption = 'Apar'#234'ncia'
          TabOrder = 5
          object Label1: TLabel
            Left = 384
            Top = 25
            Width = 94
            Height = 13
            Caption = 'Tamanho da Fonte:'
          end
          object chkZebra: TCheckBox
            Left = 16
            Top = 24
            Width = 221
            Height = 17
            Caption = 'Mostrar linhas zebradas.    Cor da Zebra:'
            TabOrder = 0
          end
          object dccZebra: TdxColorEdit
            Left = 239
            Top = 22
            TabOrder = 1
            Width = 121
          end
          object rdgAliPes: TRadioGroup
            Left = 16
            Top = 54
            Width = 344
            Height = 46
            Caption = 'Alinhamento da Pesquisa'
            Columns = 2
            ItemIndex = 1
            Items.Strings = (
              'Topo'
              'Rodap'#233)
            TabOrder = 3
          end
          object spnTanFon: TSpinEdit
            Left = 484
            Top = 22
            Width = 54
            Height = 22
            MaxValue = 12
            MinValue = 8
            TabOrder = 2
            Value = 8
          end
        end
        object chkConsCo: TCheckBox
          Left = 397
          Top = 9
          Width = 201
          Height = 17
          Hint = 
            'Realiza a consulta pelas palavras informadas no filtro independe' +
            'nte da ordem das mesmas no texto'
          Caption = 'Utilizar consulta contida'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = chkConsCoClick
        end
        object chkFetch: TCheckBox
          Left = 397
          Top = 25
          Width = 236
          Height = 17
          Hint = 
            'Realiza a consulta pelas palavras informadas no filtro independe' +
            'nte da ordem das mesmas no texto'
          Caption = 'Consulta feita em etapas (com "fetch")'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object chkExpandida: TCheckBox
          Left = 397
          Top = 41
          Width = 201
          Height = 17
          Caption = 'Expandir a aplica'#231#227'o'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object chkFilObr: TCheckBox
          Left = 397
          Top = 57
          Width = 508
          Height = 17
          Caption = 
            'Obrigat'#243'rio informar pelo menos um filtro dentre os escolhidos n' +
            'a coluna "Grupo Obrigat'#243'rio" abaixo'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
        end
        object chkFilBra: TCheckBox
          Left = 23
          Top = 54
          Width = 308
          Height = 17
          Hint = 
            'Realiza a consulta pelas palavras informadas no filtro independe' +
            'nte da ordem das mesmas no texto'
          Caption = 'Trazer o filtro sempre em branco quando for Complete Key'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 205
        Width = 1026
        Height = 26
        Align = alTop
        BevelOuter = bvNone
        Caption = 
          'Configure as Colunas que ser'#227'o exibidas e as que ser'#227'o utilizada' +
          's para pesquisa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
    end
    object tbsEmpresas: TTabSheet
      Caption = '&Empresas'
      ImageIndex = 1
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 1026
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Marque as empresas que ter'#227'o essa configura'#231#227'o'
        TabOrder = 0
      end
      object cxgEmpresas: TcxGrid
        Left = 0
        Top = 25
        Width = 1026
        Height = 498
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgEmpresasView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCadEmp
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxgEmpresasSELECI: TcxGridDBColumn
            Caption = 'Marcar'
            DataBinding.FieldName = 'SELECI'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxgEmpresasSELECIPropertiesChange
            HeaderAlignmentHorz = taCenter
            Width = 74
          end
          object cxgEmpresasCODEMP: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODEMP'
            Options.Editing = False
            Width = 64
          end
          object cxgEmpresasNOMEMP: TcxGridDBColumn
            Caption = 'Nome da Empresa'
            DataBinding.FieldName = 'NOMEMP'
            Options.Editing = False
            Width = 644
          end
        end
        object cxgEmpresasLevel1: TcxGridLevel
          GridView = cxgEmpresasView
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 523
        Width = 1026
        Height = 41
        Align = alBottom
        ParentColor = True
        TabOrder = 2
        object btnMarcaEmp: TBitBtnLocked
          Left = 16
          Top = 12
          Width = 123
          Height = 20
          Caption = '[ F6 ] Marca Todas'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btnMarcaEmpClick
        end
        object btnDesmarcaEmp: TBitBtnLocked
          Left = 139
          Top = 12
          Width = 141
          Height = 20
          Caption = '[ F7 ] Desmarca Todas'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            3333333777333777FF3333993333339993333377FF3333377FF3399993333339
            993337777FF3333377F3393999333333993337F777FF333337FF993399933333
            399377F3777FF333377F993339993333399377F33777FF33377F993333999333
            399377F333777FF3377F993333399933399377F3333777FF377F993333339993
            399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
            99333773FF3333777733339993333339933333773FFFFFF77333333999999999
            3333333777333777333333333999993333333333377777333333}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnDesmarcaEmpClick
        end
      end
    end
    object tbsFullText: TTabSheet
      Caption = '&'#205'ndices Fulltext'
      ImageIndex = 2
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 1026
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Ative os '#237'ndices Fulltext que ser'#227'o usados'
        TabOrder = 0
      end
      object cxgIndices: TcxGrid
        Left = 0
        Top = 25
        Width = 1026
        Height = 539
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgIndicesView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsFulltext
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum '#237'ndice fulltext encontrado>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          object cxgIndicesViewColumn3: TcxGridDBColumn
            Caption = 'Ativar'
            DataBinding.FieldName = 'SELECI'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 66
          end
          object cxgIndicesViewColumn4: TcxGridDBColumn
            Caption = 'Tabela'
            DataBinding.FieldName = 'NOMTAB'
            Options.Editing = False
            Width = 74
          end
          object cxgIndicesViewColumn1: TcxGridDBColumn
            Caption = 'Nome do '#237'ndice'
            DataBinding.FieldName = 'NOMIND'
            Options.Editing = False
            Width = 194
          end
          object cxgIndicesViewColumn2: TcxGridDBColumn
            Caption = 'Colunas que ser'#227'o pesquisadas'
            DataBinding.FieldName = 'DESCAM'
            Options.Editing = False
            Width = 448
          end
        end
        object cxgIndicesLevel1: TcxGridLevel
          GridView = cxgIndicesView
        end
      end
    end
    object tbsOperadores: TTabSheet
      Caption = '&Operadores'
      ImageIndex = 3
      object Panel13: TPanel
        Left = 0
        Top = 0
        Width = 1026
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Caption = 
          'Marque os Operadores ou Grupos de Operadores que ter'#227'o essa conf' +
          'igura'#231#227'o'
        TabOrder = 0
      end
      object pnlDirOpe: TPanel
        Left = 0
        Top = 25
        Width = 582
        Height = 520
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 1
        object cxgCadOpe: TcxGridCitel
          Left = 1
          Top = 22
          Width = 580
          Height = 468
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object tbvCadOpe: TcxGridDBTableViewCitel
            OnDblClick = tbvCadOpeDblClick
            OnKeyDown = tbvCadOpeKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsCadOpe
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Header = cxStyle1
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object OPE_MARDES: TcxGridDBColumn
              Caption = 'Sel.'
              DataBinding.FieldName = 'OPE_MARDES'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              HeaderAlignmentHorz = taCenter
              HeaderGlyphAlignmentHorz = taCenter
              Options.Filtering = False
              Options.Grouping = False
              Width = 26
            end
            object OPE_CODOPE: TcxGridDBColumn
              AlternateCaption = 'CODOPE'
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'OPE_CODOPE'
              Options.Editing = False
              Options.Grouping = False
              Width = 58
            end
            object OPE_NOMOPE: TcxGridDBColumn
              Caption = 'Nome'
              DataBinding.FieldName = 'OPE_NOMOPE'
              Options.Editing = False
              Options.Grouping = False
              Width = 332
            end
          end
          object cxgCadOpeLevel1: TcxGridLevel
            GridView = tbvCadOpe
          end
        end
        object Panel9: TPanel
          Left = 1
          Top = 490
          Width = 580
          Height = 29
          Align = alBottom
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object btnMarOpe: TBitBtnLocked
            Left = 1
            Top = 2
            Width = 162
            Height = 25
            Caption = '[ ENTER ] &Marcar / Desmarcar'
            TabOrder = 0
            OnClick = btnMarOpeClick
          end
          object btnMarOpeTot: TBitBtnLocked
            Left = 162
            Top = 2
            Width = 110
            Height = 25
            Caption = '&Marcar Todos'
            TabOrder = 1
            OnClick = btnMarOpeTotClick
          end
          object btnDesOpeTot: TBitBtnLocked
            Left = 271
            Top = 2
            Width = 123
            Height = 25
            Caption = '&Desmarcar Todos'
            TabOrder = 2
            OnClick = btnDesOpeTotClick
          end
        end
        object Panel10: TPanel
          Left = 1
          Top = 1
          Width = 580
          Height = 21
          Align = alTop
          TabOrder = 2
          object Label2: TLabel
            Left = 4
            Top = 3
            Width = 69
            Height = 14
            Caption = 'Operadores:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object pnlDirGpo: TPanel
        Left = 582
        Top = 25
        Width = 444
        Height = 520
        Align = alRight
        BevelOuter = bvLowered
        TabOrder = 2
        object cxgCadGpo: TcxGridCitel
          Left = 1
          Top = 22
          Width = 442
          Height = 468
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object tbvCadGpo: TcxGridDBTableViewCitel
            OnDblClick = tbvCadGpoDblClick
            OnKeyDown = tbvCadGpoKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dtsCadGpo
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.Visible = True
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Header = cxStyle1
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GPO_MARDES: TcxGridDBColumn
              Caption = 'Sel.'
              DataBinding.FieldName = 'GPO_MARDES'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              HeaderAlignmentHorz = taCenter
              HeaderGlyphAlignmentHorz = taCenter
              Options.Filtering = False
              Options.Grouping = False
              Width = 26
            end
            object GPO_CODGPO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'GPO_CODGPO'
              Options.Editing = False
              Options.Grouping = False
              Width = 45
            end
            object GPO_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'GPO_DESCRI'
              Options.Editing = False
              Options.Grouping = False
              Width = 357
            end
          end
          object cxGridLevel1: TcxGridLevel
            GridView = tbvCadGpo
          end
        end
        object Panel11: TPanel
          Left = 1
          Top = 490
          Width = 442
          Height = 29
          Align = alBottom
          Caption = 'Panel2'
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object btnMarGru: TBitBtnLocked
            Left = 5
            Top = 2
            Width = 162
            Height = 25
            Caption = '[ ENTER ] &Marcar / Desmarcar'
            TabOrder = 0
            OnClick = btnMarGruClick
          end
          object btnMarGruTot: TBitBtnLocked
            Left = 166
            Top = 2
            Width = 110
            Height = 25
            Caption = '&Marcar Todos'
            TabOrder = 1
            OnClick = btnMarGruTotClick
          end
          object btnDesGruTot: TBitBtnLocked
            Left = 275
            Top = 2
            Width = 120
            Height = 25
            Caption = '&Desmarcar Todos'
            TabOrder = 2
            OnClick = btnDesGruTotClick
          end
        end
        object Panel12: TPanel
          Left = 1
          Top = 1
          Width = 442
          Height = 21
          Align = alTop
          TabOrder = 2
          object Label3: TLabel
            Left = 5
            Top = 3
            Width = 123
            Height = 14
            Caption = 'Grupo de Operadores:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object Panel14: TPanel
        Left = 0
        Top = 545
        Width = 1026
        Height = 19
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
        object lblAltGrd: TLabel
          Left = 12
          Top = 2
          Width = 341
          Height = 14
          Caption = '[ F11 ] Alternar foco entre Operadores e Grupo de Operadores'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object dtsColunas: TDataSource
    Left = 41
    Top = 298
  end
  object dtsColSel: TDataSource
    Left = 42
    Top = 354
  end
  object dtsCadEmp: TDataSource
    Left = 39
    Top = 408
  end
  object dtsFulltext: TDataSource
    Left = 44
    Top = 467
  end
  object dtsCadOpe: TDataSource
    Left = 36
    Top = 257
  end
  object cxEstilos: TcxStyleRepository
    Left = 37
    Top = 213
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsCadGpo: TDataSource
    Left = 48
    Top = 161
  end
end
