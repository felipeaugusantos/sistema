inherited frmCadAnaliseMov: TfrmCadAnaliseMov
  Width = 1000
  Height = 626
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'An'#225'lise de Amostras'
  WindowState = wsMaximized
  ExplicitWidth = 1000
  ExplicitHeight = 626
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 544
    Width = 984
    Height = 27
    ExplicitTop = 544
    ExplicitWidth = 984
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 903
      Height = 23
      ExplicitWidth = 903
      ExplicitHeight = 23
      inherited btnIncluir: TBitBtnLocked
        Height = 23
        Align = alLeft
        ExplicitHeight = 23
      end
      inherited btnGravar: TBitBtnLocked
        Height = 23
        Align = alLeft
        ExplicitHeight = 23
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 23
        Align = alLeft
        ExplicitHeight = 23
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 23
        Align = alLeft
        ExplicitHeight = 23
      end
      inherited btnCancela: TBitBtnLocked
        Height = 23
        Align = alLeft
        ExplicitHeight = 23
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 74
        Height = 23
        Align = alLeft
        ExplicitWidth = 74
        ExplicitHeight = 23
      end
      object btnImprimir: TBitBtnLocked
        Left = 434
        Top = 0
        Width = 85
        Height = 23
        Align = alLeft
        Caption = 'Im&primir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 6
        OnClick = btnImprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 905
      Height = 23
      Align = alRight
      ExplicitLeft = 905
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 571
    Width = 984
    ExplicitTop = 571
    ExplicitWidth = 984
    inherited pnlNomeForm: TPanel
      Left = 637
      ExplicitLeft = 637
    end
    inherited pnlInfo: TPanel
      Width = 637
      ExplicitWidth = 637
    end
  end
  inherited pgcDados: TPageControl
    Width = 984
    Height = 544
    ExplicitWidth = 984
    ExplicitHeight = 544
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 976
      ExplicitHeight = 512
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 984
    Height = 544
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pnlInfoOpI: TPanel
      Left = 0
      Top = 189
      Width = 984
      Height = 355
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 982
        Height = 71
        Align = alTop
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 18
          Width = 40
          Height = 14
          AutoSize = False
          Caption = 'Produto:'
        end
        object Label3: TLabel
          Left = 606
          Top = 18
          Width = 60
          Height = 14
          AutoSize = False
          Caption = 'Volume (LT):'
        end
        object Label4: TLabel
          Left = 642
          Top = 46
          Width = 24
          Height = 14
          AutoSize = False
          Caption = 'Lote:'
        end
        object edtDesIte: TEditFocus
          Tag = 99
          Left = 54
          Top = 12
          Width = 531
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNumOpe: TEditFocus
          Tag = 99
          Left = 54
          Top = 40
          Width = 108
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesEti: TEditFocus
          Tag = 99
          Left = 167
          Top = 40
          Width = 418
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNumLot: TEditFocus
          Tag = 99
          Left = 668
          Top = 40
          Width = 108
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtVolume: TEditFocus
          Tag = 99
          Left = 668
          Top = 13
          Width = 108
          Height = 22
          Alignment = taRightJustify
          Enabled = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object cxgAnalises: TcxGrid
        Left = 1
        Top = 72
        Width = 982
        Height = 282
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgAnalisesView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnEditing = cxgAnalisesViewEditing
          OnInitEdit = cxgAnalisesViewInitEdit
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          object cxgAnalisesCODANA: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ANA_CODANA'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 1
            SortOrder = soAscending
            Width = 70
          end
          object cxgAnalisesDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o da An'#225'lise'
            DataBinding.FieldName = 'ANA_DESCRI'
            Options.Editing = False
            Width = 274
          end
          object cxgAnalisesRESESP: TcxGridDBColumn
            Caption = 'Resultado Esperado'
            DataBinding.FieldName = 'RESESP'
            PropertiesClassName = 'TcxLabelProperties'
            OnGetDataText = cxgAnalisesRESESPGetDataText
            Options.Editing = False
            Width = 210
          end
          object cxgAnalisesRESULT: TcxGridDBColumn
            Caption = 'Resultado'
            DataBinding.FieldName = 'DET_RESULT'
            HeaderAlignmentHorz = taCenter
            Width = 210
          end
          object cxgAnalisesSITUACAO: TcxGridDBColumn
            Caption = 'Situa'#231#227'o'
            DataBinding.FieldName = 'SITUACAO'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            OnCustomDrawCell = cxgAnalisesSITUACAOCustomDrawCell
            HeaderAlignmentHorz = taCenter
            Width = 110
          end
          object cxgAnalisesSTATUS: TcxGridDBColumn
            DataBinding.FieldName = 'DET_STATUS'
            Visible = False
          end
          object cxgAnalisesDESTIPANA: TcxGridDBColumn
            Caption = 'Tipo de An'#225'lise'
            DataBinding.FieldName = 'DESTIPANA'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 0
            SortOrder = soDescending
            Width = 124
          end
          object cxgAnalisesOBSERV: TcxGridDBColumn
            Caption = 'Observa'#231#227'o'
            DataBinding.FieldName = 'DET_OBSERV'
            Width = 650
          end
          object cxgAnalisesTIPANA: TcxGridDBColumn
            Caption = 'Tipo'
            DataBinding.FieldName = 'ANA_TIPANA'
            Visible = False
            HeaderAlignmentHorz = taCenter
          end
          object cxgAnalisesTIPRES: TcxGridDBColumn
            DataBinding.FieldName = 'ANA_TIPRES'
            Visible = False
          end
          object cxgAnalisesLIMMIN: TcxGridDBColumn
            DataBinding.FieldName = 'ANA_LIMMIN'
            Visible = False
          end
          object cxgAnalisesLIMMAX: TcxGridDBColumn
            DataBinding.FieldName = 'ANA_LIMMAX'
            Visible = False
          end
          object cxgAnalisesDESRES: TcxGridDBColumn
            DataBinding.FieldName = 'ANA_DESRES'
            Visible = False
          end
          object cxgAnalisesNOMOPE: TcxGridDBColumn
            Caption = 'Operador que realizou a an'#225'lise'
            DataBinding.FieldName = 'NOMOPE'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = Action1
                Default = True
                Glyph.SourceDPI = 96
                Glyph.Data = {
                  424D360400000000000036000000280000001000000010000000010020000000
                  000000000000C40E0000C40E0000000000000000000000000000000000000000
                  00000000000000000000000000000000000000000002000000070000000B0000
                  000D00000010000000100000000F0000000E0000000A00000000000000000000
                  0000000000000000000000000000000000000000000615513AA51A6446D31864
                  46DC1A724EFF166C49FF105438DD0E4C33D6093824AD00000000000000000000
                  00000000000000000000000000000000000000000007298D68FA6CCBADFF66C8
                  A8FF4DBD98FF30A97BFF28986EFF379F79FF156545FA000000020000000A0000
                  00160000001B000000170000000B00000002000000041646337D339672F65DBB
                  9CFF71CBB0FF4FB794FF3AA17CFF237B5BF60D3626820000000F261610725834
                  24D8693D2AFF4D2C1FD91D110B75000000130000000A4539357B877C73E65586
                  74FF3A7086FF346780FF1B503FBC0309072300000005291A136DA38070FFD4C5
                  BDFFEDE5E1FFCFBEB7FF907163FF1E120C792C1C166AA48577FFD9D1CDFF6884
                  A6FF7DA4CDFF588BC1FF26436AE40000001C00000000734937DEE3D7D1FFCEAE
                  9EFFAF7957FFD0B39EFFD7C9C3FF533123E177503FDBEAE3E0FFCEC0B8FF577D
                  B0FFBDE0F5FF8BC2EBFF345D96FF01030535000000038E5A47FBF8F6F4FFAE72
                  5BFFE7AF66FFB27F5EFFF0EBE8FF704533FF9A6B55FFF6F5F4FF4C6189FF5C80
                  B0FFCAE8F6FF94C6E9FF375D95FF0F2346B00000000990604DF8F1E8E4FFD2B0
                  A5FFAA6C53FFD4B6A7FFCDC0BAFF6D402EFF80513DFFF2EDEAFF295898FF4F7C
                  B1FF517CAFFF2C5088FF325D98FF183871F40000000B583C31A2CAAFA3FFF7F2
                  EEFFFDFCFBFFEAE0DAFF9E847AFF744634FF855944FFF0E8E3FF3D73B2FF6C9E
                  D1FF5C8CC1FF76A5D3FF5385BEFF1C427DF7000000070805041D9F725DF8E8DB
                  D4FFE6D7CEFFCDB7AAFF8B6B5EFF7A4A39FF8B5F4BFFF2E8E3FFBAC7D8FF5D8F
                  C6FF4280C2FF3375BCFF234F84CE0A192D5A000000030000000760473BA4D0B7
                  ADFFEEE3DFFFD5C1B7FF93766CFF7F513EFF926550FFEFE4DEFFF1E9E6FFDCD1
                  CBFFCAB8B0FF8C7971BA0000000700000002000000000000000222191541B893
                  83FFF3EBE8FFD9C9C2FFA99389FFA37764FFB48B76FFF0E7E3FFEADED9FFBDA7
                  9FFFA67D6CFF2119153900000001000000000000000000000000000000078465
                  54C6DDCCC4FFE6DCD8FFC2A99EFFA57D68F9B38E79F8E0D1C9FFE9DFDAFFBCA4
                  97FF846555C2000000030000000000000000000000000000000000000002130F
                  0D237D6152B7AF8673FA7B6050B9130E0C2814100E20836558B3B68F79F98064
                  55B3130F0D1E0000000100000000000000000000000000000000000000000000
                  0001000000040000000600000005000000020000000000000001000000010000
                  00010000000000000000000000000000000000000000}
                Kind = bkEllipsis
              end>
            Width = 241
          end
        end
        object cxgAnalisesLevel1: TcxGridLevel
          GridView = cxgAnalisesView
        end
      end
    end
    object pnlCampos: TPanel
      Left = 0
      Top = 0
      Width = 984
      Height = 189
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 1
      object gpbLibera: TGroupBox
        Left = 33
        Top = 94
        Width = 648
        Height = 47
        Caption = 'Liber'#231#227'o do Lote'
        Enabled = False
        TabOrder = 1
        object Label7: TLabel
          Left = 78
          Top = 25
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object Label6: TLabel
          Left = 333
          Top = 27
          Width = 123
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data/Hora da Finaliza'#231#227'o:'
        end
        object edtStatus: TEditFocus
          Left = 127
          Top = 21
          Width = 165
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaBai: TDBEditFocus
          Tag = 99
          Left = 458
          Top = 21
          Width = 87
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'GER_DTABAI'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeHorBai: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 21
          Width = 87
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'GER_HORBAI'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
      end
      object gpbAcompanha: TGroupBox
        Left = 33
        Top = 141
        Width = 648
        Height = 46
        Caption = 'Acompanhamento do Lote'
        Enabled = False
        TabOrder = 2
        object Label8: TLabel
          Left = 78
          Top = 25
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object Label9: TLabel
          Left = 333
          Top = 27
          Width = 123
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data/Hora da Finaliza'#231#227'o:'
        end
        object edtStaAco: TEditFocus
          Left = 127
          Top = 21
          Width = 165
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaAco: TDBEditFocus
          Tag = 99
          Left = 458
          Top = 21
          Width = 87
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'GER_DTAACO'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dtaHorAco: TDBEditFocus
          Tag = 99
          Left = 546
          Top = 21
          Width = 87
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'GER_HORACO'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
      end
      object gpbCabecalho: TGroupBox
        Left = 1
        Top = 1
        Width = 982
        Height = 44
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 20
          Top = 19
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label5: TLabel
          Left = 234
          Top = 19
          Width = 154
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#250'mero da Ordem de Produ'#231#227'o:'
        end
        object LbComponenteB: TLabel
          Left = 579
          Top = 19
          Width = 165
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ordem de Produ'#231#227'o Componente :'
        end
        object dbeCodigo: TDBEditFocus
          Tag = 99
          Left = 62
          Top = 15
          Width = 85
          Height = 22
          CharCase = ecUpperCase
          DataField = 'GER_CODIGO'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtNumOrd: TEditFocus
          Tag = 99
          Left = 392
          Top = 15
          Width = 33
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          MaxLength = 3
          TabOrder = 1
          OnKeyPress = edtNumOrdKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object mskDtaCad: TMaskEditFocus
          Tag = 99
          Left = 428
          Top = 15
          Width = 63
          Height = 22
          Enabled = False
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 2
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object edtNumOrdB: TEditFocus
          Tag = 99
          Left = 748
          Top = 15
          Width = 33
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          MaxLength = 3
          TabOrder = 3
          OnKeyPress = edtNumOrdBKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object mkDtaCadB: TMaskEditFocus
          Tag = 99
          Left = 784
          Top = 15
          Width = 64
          Height = 22
          Enabled = False
          EditMask = '99/99/9999;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 4
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
      end
      object pnlMassaVolume: TPanel
        Left = 1
        Top = 45
        Width = 982
        Height = 50
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object Label11: TLabel
          Left = 611
          Top = 7
          Width = 108
          Height = 14
          Alignment = taRightJustify
          Caption = 'Massa Componente B:'
        end
        object Label10: TLabel
          Left = 256
          Top = 8
          Width = 108
          Height = 14
          Alignment = taRightJustify
          Caption = 'Massa Componente A:'
        end
        object Label12: TLabel
          Left = 253
          Top = 32
          Width = 111
          Height = 14
          Alignment = taRightJustify
          Caption = 'Volume Componente A:'
        end
        object Label13: TLabel
          Left = 608
          Top = 32
          Width = 111
          Height = 14
          Alignment = taRightJustify
          Caption = 'Volume Componente B:'
        end
        object dbeMassaCompA: TDBEditFocus
          Tag = 99
          Left = 369
          Top = 3
          Width = 62
          Height = 22
          DataField = 'GER_MASSAA'
          DataSource = dtsTabela
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeVolumeCompA: TDBEditFocus
          Tag = 99
          Left = 369
          Top = 26
          Width = 62
          Height = 22
          DataField = 'GER_VOLUMA'
          DataSource = dtsTabela
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeVolumeCompB: TDBEditFocus
          Tag = 99
          Left = 726
          Top = 26
          Width = 62
          Height = 22
          DataField = 'GER_VOLUMB'
          DataSource = dtsTabela
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeMassaCompB: TDBEditFocus
          Tag = 99
          Left = 726
          Top = 3
          Width = 62
          Height = 22
          DataField = 'GER_MASSAB'
          DataSource = dtsTabela
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
      end
    end
  end
  object dbeCodEmp: TDBEditFocus [4]
    Tag = 99
    Left = -42
    Top = 84
    Width = 46
    Height = 22
    DataField = 'GER_CODEMP'
    DataSource = dtsTabela
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    TabOrder = 4
    Visible = False
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 688
    Top = 296
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 296
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 632
    Top = 360
  end
  object dtsTabela: TDataSource
    Left = 577
    Top = 408
  end
  object ActionList1: TActionList
    Left = 480
    Top = 448
    object Action1: TAction
      OnExecute = Action1Execute
    end
  end
end
