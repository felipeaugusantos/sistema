inherited frmGerAvisoEmbarque: TfrmGerAvisoEmbarque
  Width = 628
  Height = 500
  BorderIcons = [biSystemMenu]
  Caption = 'Gera'#231#227'o de Aviso de Embarque (EDI)'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 628
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 622
    TabOrder = 1
    ExplicitTop = 427
    ExplicitWidth = 622
    inherited FlwBotoes: TFlowPanel
      Width = 618
      TabOrder = 4
      ExplicitWidth = 618
    end
    inherited btnSair: TBitBtnLocked
      Left = 539
      TabOrder = 3
      ExplicitLeft = 539
    end
    object btnGravar: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 98
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '[F10] Confirma'
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
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnMarcaTodos: TBitBtnLocked
      Left = 102
      Top = 3
      Width = 110
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '[F6] Marca Todos'
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
      TabOrder = 1
      OnClick = btnMarcaTodosClick
    end
    object btnDesmarcaTodos: TBitBtnLocked
      Left = 212
      Top = 3
      Width = 129
      Height = 22
      Anchors = [akLeft, akBottom]
      Caption = '[F7] Desmarca Todos'
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
      TabOrder = 2
      OnClick = btnDesmarcaTodosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 622
    TabOrder = 2
    ExplicitTop = 455
    ExplicitWidth = 622
    inherited pnlNomeForm: TPanel
      Left = 451
      TabOrder = 1
      ExplicitLeft = 451
    end
    inherited pnlInfo: TPanel
      Width = 451
      TabOrder = 0
      ExplicitWidth = 451
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 622
    Height = 427
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lbl3: TLabel
      Left = 22
      Top = 67
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 89
      Top = 67
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDesDtaFin: TLabel
      Left = 158
      Top = 85
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCliFor: TLabel
      Left = 22
      Top = 104
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object grpDocumento: TGroupBox
      Left = 12
      Top = 6
      Width = 162
      Height = 60
      Caption = 'Documento de Venda:'
      TabOrder = 0
      object lbl1: TLabel
        Left = 7
        Top = 15
        Width = 37
        Height = 14
        Caption = 'N'#250'mero'
      end
      object lbl5: TLabel
        Left = 91
        Top = 15
        Width = 21
        Height = 14
        Caption = 'Esp.'
      end
      object lblEmpresa: TLabel
        Left = 117
        Top = 15
        Width = 23
        Height = 14
        Caption = 'Emp.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtNumDoc: TEditFocus
        Tag = 99
        Left = 7
        Top = 29
        Width = 80
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 12
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 88
        Top = 29
        Width = 25
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 1
        Text = 'NF'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 114
        Top = 29
        Width = 40
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        Text = '001'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
    end
    object rdgGeradas: TRadioGroup
      Tag = 99
      Left = 180
      Top = 6
      Width = 168
      Height = 60
      Caption = 'Aviso de Embarque'
      ItemIndex = 1
      Items.Strings = (
        'J'#225' geradas'
        'N'#227'o geradas')
      TabOrder = 1
    end
    object rdgCFOP: TRadioGroup
      Left = 354
      Top = 6
      Width = 181
      Height = 60
      Caption = 'CFOP'
      ItemIndex = 0
      Items.Strings = (
        'Todos CFOPs'
        'Somente CFOP de Venda')
      TabOrder = 2
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 22
      Top = 81
      Width = 61
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 89
      Top = 81
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 22
      Top = 118
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 5
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 87
      Top = 118
      Width = 314
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbgConsulta: TDBGridCitel
      Left = 1
      Top = 151
      Width = 620
      Height = 222
      Align = alBottom
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 8
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgConsultaDrawColumnCell
      OnDblClick = dbgConsultaDblClick
      OnKeyDown = dbgConsultaKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DTAENT'
          ReadOnly = True
          Title.Caption = 'Dt.Venda'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMDOC'
          ReadOnly = True
          Title.Caption = 'Documento'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESPDOC'
          ReadOnly = True
          Title.Caption = 'Esp.'
          Width = 24
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODEMP'
          ReadOnly = True
          Title.Caption = 'Emp.'
          Width = 26
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMCLI'
          ReadOnly = True
          Title.Caption = 'Cliente'
          Width = 283
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VLRCON'
          ReadOnly = True
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Total'
          Width = 78
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'GERAVE'
          Title.Alignment = taCenter
          Title.Caption = 'Gerada'
          Width = 40
          Visible = True
        end>
    end
    object pnlBottom: TPanel
      Left = 1
      Top = 373
      Width = 620
      Height = 53
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 9
      object Label1: TLabel
        Left = 8
        Top = 2
        Width = 104
        Height = 14
        Caption = 'Path para Exporta'#231#227'o'
      end
      object pgbProgresso: TProgressBar
        Left = 1
        Top = 42
        Width = 618
        Height = 10
        Align = alBottom
        Smooth = True
        TabOrder = 1
        Visible = False
      end
      inline fraPatExp: TfraDirectoryEditFocus
        Left = 8
        Top = 17
        Width = 601
        Height = 24
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitLeft = 8
        ExplicitTop = 17
        ExplicitWidth = 601
        ExplicitHeight = 24
        inherited edtDirectory: TEditFocus
          Width = 576
          Height = 22
          ExplicitWidth = 576
          ExplicitHeight = 22
        end
        inherited btnOpenDirectory: TcxButton
          Left = 578
          Height = 24
          ExplicitLeft = 578
          ExplicitHeight = 24
        end
      end
    end
    object btnConsultar: TBitBtnLocked
      Left = 406
      Top = 118
      Width = 81
      Height = 22
      Caption = '&Consultar'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 7
      OnClick = btnConsultarClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1102
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1104
    Top = 126
  end
  object dtsConsulta: TDataSource
    Left = 570
    Top = 210
  end
end
