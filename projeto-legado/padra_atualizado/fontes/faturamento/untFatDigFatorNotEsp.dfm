inherited frmFatDigFatorNotEsp: TfrmFatDigFatorNotEsp
  Left = 215
  Top = 173
  Width = 710
  Height = 416
  BorderIcons = [biSystemMenu]
  Caption = 'Fator para nota especial'
  Position = poMainFormCenter
  ExplicitWidth = 710
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 347
    Width = 704
    Height = 24
    ExplicitTop = 347
    ExplicitWidth = 704
    ExplicitHeight = 24
    inherited FlwBotoes: TFlowPanel
      Left = 125
      Width = 500
      Height = 20
      TabOrder = 2
      ExplicitLeft = 125
      ExplicitWidth = 500
      ExplicitHeight = 20
    end
    inherited btnSair: TBitBtnLocked
      Left = 625
      Top = 2
      Height = 20
      Align = alRight
      ExplicitLeft = 625
      ExplicitTop = 2
      ExplicitHeight = 20
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 123
      Height = 20
      Align = alLeft
      Caption = 'F10 - &Confirma'
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
      OnClick = btnConfirmaDadosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 371
    Width = 704
    ExplicitTop = 371
    ExplicitWidth = 704
    inherited pnlNomeForm: TPanel
      Left = 533
      ExplicitLeft = 533
    end
    inherited pnlInfo: TPanel
      Width = 533
      ExplicitWidth = 533
    end
  end
  object rdgOpcoes: TRadioGroup [2]
    Left = 0
    Top = 0
    Width = 704
    Height = 45
    Align = alTop
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Por Documento'
      'Por Per'#237'odo')
    TabOrder = 2
    OnClick = rdgOpcoesClick
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 45
    Width = 704
    Height = 302
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Notebook: TNotebook
      Left = 1
      Top = 1
      Width = 702
      Height = 300
      Align = alClient
      PageIndex = 1
      TabOrder = 0
      ExplicitLeft = 97
      ExplicitTop = -2
      object TPage
        Left = 0
        Top = 0
        Caption = 'por_documento'
        object Label1: TLabel
          Left = 140
          Top = 78
          Width = 57
          Height = 14
          Caption = 'Documento:'
        end
        object Label2: TLabel
          Left = 156
          Top = 101
          Width = 41
          Height = 14
          Caption = 'Esp'#233'cie:'
        end
        object Label3: TLabel
          Left = 152
          Top = 124
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object lblFatCal: TLabel
          Left = 169
          Top = 171
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fator:'
        end
        object lblTipoFator: TLabel
          Left = 287
          Top = 171
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Fator:'
          Visible = False
        end
        object clbTipoFator: TColorLabel
          Left = 385
          Top = 171
          Width = 100
          Height = 14
          Caption = '(V)alor (Q)uantidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
          CorDestaque = clRed
        end
        object Label4: TLabel
          Left = 162
          Top = 147
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
        end
        object lblSerDoc: TLabel
          Left = 265
          Top = 101
          Width = 28
          Height = 14
          Caption = 'S'#233'rie:'
        end
        object edtNumDoc: TEditFocus
          Tag = 99
          Left = 200
          Top = 75
          Width = 132
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
        object edtNomEmp: TEditFocus
          Left = 252
          Top = 121
          Width = 294
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEspDoc: TEditFocus
          Tag = 99
          Left = 200
          Top = 98
          Width = 50
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 1
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
          Left = 200
          Top = 121
          Width = 50
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 3
          OnKeyPress = edtCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtFatCal: TEditFocus
          Tag = 99
          Left = 200
          Top = 167
          Width = 77
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          OnEnter = edtFatCalEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,####0.0000'
        end
        object edtTipoFator: TEditFocus
          Tag = 99
          Left = 359
          Top = 167
          Width = 21
          Height = 22
          Alignment = taCenter
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          Text = 'V'
          Visible = False
          OnEnter = edtTipoFatorEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 200
          Top = 144
          Width = 77
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
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
          Left = 278
          Top = 144
          Width = 268
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 6
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSerDoc: TEditFocus
          Tag = 99
          Left = 296
          Top = 98
          Width = 36
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'por_periodo'
        DesignSize = (
          702
          300)
        object Label5: TLabel
          Left = 52
          Top = 57
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object Label7: TLabel
          Left = 43
          Top = 10
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Inicial:'
        end
        object lbl1: TLabel
          Left = 174
          Top = 10
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Final:'
        end
        object Label6: TLabel
          Left = 56
          Top = 34
          Width = 41
          Height = 14
          Caption = 'Esp'#233'cie:'
        end
        object lblSerDoc_: TLabel
          Left = 195
          Top = 34
          Width = 28
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'S'#233'rie:'
        end
        object edtCodEmp_: TEditFocus
          Tag = 99
          Left = 100
          Top = 54
          Width = 50
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 4
          OnKeyPress = edtCodEmp_KeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtNomEmp_: TEditFocus
          Left = 152
          Top = 54
          Width = 294
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 100
          Top = 6
          Width = 68
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object mskDtaFin: TMaskEditFocus
          Tag = 99
          Left = 229
          Top = 6
          Width = 71
          Height = 22
          EditMask = '99/99/9999'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object btnPesquisa: TBitBtnLocked
          Left = 452
          Top = 54
          Width = 85
          Height = 22
          Caption = '&Pesquisar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
            CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
            1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
            7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
            D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
            A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
            81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
            7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
            A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
            93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
            E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
            BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
            A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
            EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
            D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
            B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
            8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
            55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
            E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
            6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
            926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 6
          OnClick = btnPesquisaClick
        end
        object dbgDocumentos: TDBGridCitel
          Left = 0
          Top = 99
          Width = 702
          Height = 141
          Align = alBottom
          DataSource = dtsDocumentos
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
          ReadOnly = True
          TabOrder = 7
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDrawColumnCell = dbgDocumentosDrawColumnCell
          OnDblClick = dbgDocumentosDblClick
          OnKeyPress = dbgDocumentosKeyPress
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'GER_DTAENT'
              Title.Alignment = taCenter
              Title.Caption = 'Dt. Emiss'#227'o'
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOCUMENTO'
              Title.Caption = 'Documento'
              Width = 142
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CLIENTE'
              Title.Caption = 'Cliente'
              Width = 277
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'GER_VLRCON'
              Title.Alignment = taRightJustify
              Title.Caption = 'Vr. Documento'
              Width = 90
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'TOTITENS'
              Title.Alignment = taRightJustify
              Title.Caption = 'Qtd. Itens'
              Width = 75
              Visible = True
            end>
        end
        object edtEspDoc_: TEditFocus
          Tag = 99
          Left = 100
          Top = 30
          Width = 50
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object pnlRodape: TPanel
          Left = 0
          Top = 240
          Width = 702
          Height = 60
          Align = alBottom
          Enabled = False
          TabOrder = 8
          object Label8: TLabel
            Left = 79
            Top = 34
            Width = 28
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fator:'
          end
          object lblTipoFator_: TLabel
            Left = 193
            Top = 34
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Fator:'
            Visible = False
          end
          object clbTipoFator_: TColorLabel
            Left = 289
            Top = 34
            Width = 100
            Height = 14
            Caption = '(V)alor (Q)uantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Visible = False
            CorDestaque = clRed
          end
          object Label10: TLabel
            Left = 72
            Top = 10
            Width = 35
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cliente:'
          end
          object Label9: TLabel
            Left = 464
            Top = 10
            Width = 117
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd. Itens Selecionados:'
          end
          object edtFatCal_: TEditFocus
            Tag = 99
            Left = 110
            Top = 30
            Width = 77
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            OnEnter = edtFatCal_Enter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,####0.0000'
          end
          object edtTipoFator_: TEditFocus
            Tag = 99
            Left = 262
            Top = 30
            Width = 21
            Height = 22
            Alignment = taCenter
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 6
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Text = 'V'
            Visible = False
            OnEnter = edtTipoFator_Enter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfabetico
          end
          object edtCodCli_: TEditFocus
            Tag = 99
            Left = 110
            Top = 6
            Width = 77
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 8
            TabOrder = 0
            OnKeyPress = edtCodCli_KeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtNomCli_: TEditFocus
            Left = 188
            Top = 6
            Width = 258
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtTotItensSelecionados: TEditFocus
            Left = 587
            Top = 6
            Width = 93
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 4
            Text = '0'
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object edtSerDoc_: TEditFocus
          Tag = 99
          Left = 229
          Top = 30
          Width = 36
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 256
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 256
  end
  object dtsDocumentos: TDataSource
    Left = 200
    Top = 256
  end
end
