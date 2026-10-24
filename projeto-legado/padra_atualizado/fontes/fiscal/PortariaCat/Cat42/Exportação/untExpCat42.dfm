inherited frmExpCat42: TfrmExpCat42
  Width = 516
  Height = 311
  BorderIcons = [biSystemMenu]
  Caption = 'Exporta'#231#227'o Cat - 42'
  OnShow = FormShow
  ExplicitWidth = 516
  ExplicitHeight = 311
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 236
    Width = 510
    Height = 30
    TabOrder = 1
    ExplicitTop = 236
    ExplicitWidth = 510
    ExplicitHeight = 30
    inherited btnSair: TBitBtn
      Left = 418
      Top = 2
      Width = 90
      Height = 26
      Align = alRight
      TabOrder = 1
      ExplicitLeft = 418
      ExplicitTop = 2
      ExplicitWidth = 90
      ExplicitHeight = 26
    end
    object btnConfirma: TBitBtn
      Left = 2
      Top = 2
      Width = 90
      Height = 26
      Align = alLeft
      Caption = '&Confirma'
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
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 266
    Width = 510
    TabOrder = 0
    ExplicitTop = 266
    ExplicitWidth = 510
    inherited pnlNomeForm: TPanel
      Left = 339
      ExplicitLeft = 339
    end
    inherited pnlInfo: TPanel
      Width = 339
      ExplicitWidth = 339
      inherited btnShowTrace: TSpeedButton
        Left = 337
        ExplicitLeft = 337
      end
      inherited btnHideTrace: TSpeedButton
        Left = 337
        ExplicitLeft = 337
      end
    end
  end
  object pgbProgresso: TProgressBar [2]
    AlignWithMargins = True
    Left = 3
    Top = 221
    Width = 504
    Height = 12
    Align = alBottom
    Smooth = True
    TabOrder = 2
  end
  object pgcControle: TPageControl [3]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 504
    Height = 212
    ActivePage = tbsGeral
    Align = alClient
    Style = tsButtons
    TabHeight = 30
    TabOrder = 3
    object tbsGeral: TTabSheet
      Caption = 'Geral'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 490
        Height = 166
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 3
          Top = 95
          Width = 110
          Height = 14
          Caption = 'Pasta para exporta'#231#227'o'
        end
        object lbl1: TLabel
          Left = 3
          Top = 11
          Width = 51
          Height = 14
          BiDiMode = bdRightToLeft
          Caption = 'Data Inicial'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
        end
        object lbl3: TLabel
          Left = 68
          Top = 11
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
        object lblCodEmp: TLabel
          Left = 3
          Top = 54
          Width = 42
          Height = 14
          BiDiMode = bdRightToLeft
          Caption = 'Empresa'
          ParentBiDiMode = False
        end
        object lblOperacao: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 152
          Width = 113
          Height = 14
          Align = alBottom
          Caption = 'descri'#231#227'o da operacao'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsItalic]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          Visible = False
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 3
          Top = 70
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
          OnExit = edtCodEmpExit
          OnKeyPress = edtCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtNomEmp: TEditFocus
          Left = 68
          Top = 70
          Width = 418
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object mskDtaFin: TMaskEditFocus
          Tag = 99
          Left = 68
          Top = 27
          Width = 64
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 3
          Top = 27
          Width = 62
          Height = 22
          EditMask = '99/99/9999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
      end
    end
    object tbsOpcoes: TTabSheet
      Caption = 'Op'#231#245'es'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 490
        Height = 166
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 6
          Top = 11
          Width = 71
          Height = 14
          Caption = 'Vers'#227'o Layout'
        end
        object Label3: TLabel
          Left = 83
          Top = 11
          Width = 97
          Height = 14
          Caption = 'C'#243'digo da finalidade'
        end
        object edtVersaoLayout: TEditFocus
          Left = 6
          Top = 27
          Width = 71
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object cmbFinalidade: TComboBoxFocus
          Left = 83
          Top = 27
          Width = 404
          Height = 22
          ItemIndex = 0
          TabOrder = 1
          Text = '00 - Remessa regular de arquivo'
          Items.Strings = (
            '00 - Remessa regular de arquivo'
            '01 - Remessa de arquivo requerido por intima'#231#227'o espec'#237'fica'
            
              '02 - Remessa de arquivo para substitui'#231#227'o de arquivo remetido an' +
              'teriormente')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object chkEnviarIsentoParaInsEst: TCheckBox
          Left = 6
          Top = 58
          Width = 481
          Height = 17
          Caption = 'Enviar '#39'ISENTO'#39' a(s) Inscri'#231#227'o('#245'es) Estadual(is) em Branco'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
    end
  end
  object edtPatExp: TDirectoryEditFocus [4]
    Left = 13
    Top = 154
    Properties.Buttons = <
      item
        Default = True
        Glyph.SourceDPI = 96
        Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000004080FF4060A0FF4060
          A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060A0FF4060
          A0FF4060A0FF4060A0FF004080FF00000000000000004060A0FF4060A0FF80A0
          E0FF80C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0
          E0FF40A0E0FF40A0E0FF4080C0FF002040FF000000004060A0FF4080C0FF4080
          C0FF80E0E0FF80C0E0FF40C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0E0FF40A0
          E0FF40A0E0FF40A0E0FF40A0E0FF004080FF000000004060C0FF80A0E0FF4080
          C0FF80E0E0FF80E0E0FF80C0E0FF80C0E0FF80C0E0FF40C0E0FF40C0E0FF40C0
          E0FF40C0E0FF40A0E0FF40A0E0FF4060C0FF000000004080C0FF80C0E0FF40A0
          E0FF80C0E0FFF0FBFFFF80C0E0FF80C0E0FF80C0E0FF80C0E0FF80C0E0FF80C0
          E0FF80C0E0FF80C0E0FF80C0E0FF4080C0FF002040FF4080C0FF80E0E0FF80C0
          E0FF40A0E0FFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FB
          FFFFF0FBFFFFF0FBFFFFF0FBFFFF80C0E0FF406080FF4080C0FFF0FBFFFF80E0
          E0FF80C0E0FF40A0E0FF40A0E0FF40A0E0FF40A0C0FF40A0C0FF40A0C0FF40A0
          C0FF40A0C0FF4080C0FF4080C0FF4080C0FF4060A0FF4080C0FFF0FBFFFF80E0
          E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0E0FF80E0
          E0FF80E0E0FF4060C0FF0000000000000000000000004080C0FFF0FBFFFF80E0
          E0FF80E0E0FF80E0E0FF80E0E0FFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FB
          FFFFF0FBFFFF4080C0FF00000000000000000000000040A0C0FFF0FBFFFFF0FB
          FFFFF0FBFFFFF0FBFFFFF0FBFFFF40A0C0FF4080C0FF4080C0FF4080C0FF4080
          C0FF4080C0FF4060A0FF00000000000000000000000040A0C0FFF0FBFFFFF0FB
          FFFFF0FBFFFFF0FBFFFF4080C0FF000000000000000000000000000000000000
          000000000000000000000000000000000000000000004080A0FF40A0E0FF40A0
          E0FF40A0E0FF40A0C0FF004040FF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000}
        Kind = bkGlyph
      end>
    StyleFocused.Color = clInfoBk
    TabOrder = 4
    Width = 483
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 112
  end
end
