inherited frmCadReceitAgronomicoExpCrea: TfrmCadReceitAgronomicoExpCrea
  Width = 566
  Height = 304
  Caption = 'Cadastro de Receitu'#225'rio Agron'#244'mico - Exporta'#231#227'o CREA-SP'
  Position = poMainFormCenter
  ExplicitWidth = 566
  ExplicitHeight = 304
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 8
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
  object Label2: TLabel [1]
    Left = 98
    Top = 8
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
  object Label3: TLabel [2]
    Left = 195
    Top = 25
    Width = 57
    Height = 14
    Caption = '(EMISS'#195'O)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel [3]
    Left = 8
    Top = 51
    Width = 32
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cliente'
  end
  object lbl4: TLabel [4]
    Left = 8
    Top = 95
    Width = 63
    Height = 14
    Alignment = taRightJustify
    Caption = 'Respons'#225'vel'
  end
  object lbl2: TLabel [5]
    Left = 8
    Top = 139
    Width = 60
    Height = 14
    Alignment = taRightJustify
    Caption = 'N'#250'mero ART'
  end
  object lbl5: TLabel [6]
    Left = 167
    Top = 139
    Width = 76
    Height = 14
    Alignment = taRightJustify
    Caption = 'N'#250'mero Receita'
  end
  object Label5: TLabel [7]
    Left = 7
    Top = 183
    Width = 123
    Height = 14
    Alignment = taRightJustify
    Caption = 'Diret'#243'rio para exporta'#231#227'o'
  end
  inherited pnlBotoes: TPanel
    Top = 259
    Width = 560
    ExplicitTop = 260
    ExplicitWidth = 560
  end
  inherited pgcDados: TPageControl
    Left = 1500
    Top = -6
    Width = 80
    Height = 80
    Align = alNone
    ExplicitLeft = 1500
    ExplicitTop = -6
    ExplicitWidth = 80
    ExplicitHeight = 80
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 72
      ExplicitHeight = 48
    end
  end
  object mskDtaIni: TMaskEditFocus [11]
    Tag = 99
    Left = 8
    Top = 23
    Width = 87
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
    ValidaData = True
  end
  object mskDtaFin: TMaskEditFocus [12]
    Tag = 99
    Left = 98
    Top = 22
    Width = 88
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
    ValidaData = True
  end
  object edtCodCli: TEditFocus [13]
    Tag = 99
    Left = 8
    Top = 66
    Width = 70
    Height = 22
    Alignment = taLeftJustify
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
  object edtNomCli: TEditFocus [14]
    Left = 80
    Top = 66
    Width = 468
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 10
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodRes: TEditFocus [15]
    Tag = 99
    Left = 8
    Top = 110
    Width = 70
    Height = 22
    Alignment = taLeftJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 8
    TabOrder = 6
    OnKeyPress = edtCodResKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 8
    TipoTexto = ttNumerico
  end
  object edtNomRes: TEditFocus [16]
    Left = 80
    Top = 110
    Width = 468
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 11
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtNumArt: TEditFocus [17]
    Tag = 99
    Left = 8
    Top = 154
    Width = 153
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 20
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 20
    TipoTexto = ttAlfanumerico
  end
  object edtNumRec: TEditFocus [18]
    Tag = 99
    Left = 167
    Top = 154
    Width = 106
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 16
    TabOrder = 8
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 6
    TipoTexto = ttAlfanumerico
  end
  object btnExportar: TBitBtnLocked [19]
    Left = 8
    Top = 227
    Width = 153
    Height = 25
    Caption = 'Exportar Arquivos'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000090000
      000E000000100000001000000010000000100000001000000011000000110000
      001100000011000000100000000B00000003000000000000000017417CCA2159
      A8FF225BAAFF225AAAFF2159A9FF2158A9FF2057A8FF2057A7FF2055A7FF1F55
      A7FF1F54A6FF1E53A6FF1E52A4FF1A458DE303080F2900000002225DA8FF2F6B
      B0FF579AD3FF71BEECFF46A6E4FF44A3E4FF41A1E3FF3FA0E2FF3C9EE2FF3B9C
      E1FF389BE0FF369AE0FF3498DFFF2875C1FF0F284E8B000000082868B1FF4884
      BFFF4489C7FF9CD8F5FF63B9EBFF55B0E8FF52AEE8FF4EACE7FF4CA9E6FF49A8
      E5FF47A6E4FF44A4E4FF41A2E3FF3991D7FF1B4787D50000000D2C6FB7FF6CA7
      D2FF3C87C6FFA0D4EFFF94D5F4FF66BDEEFF63BBEDFF60B9EBFF5DB6EBFF5BB5
      EAFF57B2EAFF55B0E9FF51AEE7FF4FABE7FF2967B4FF040B142F2F75BCFF8FC7
      E6FF4FA0D5FF7FBCE2FFC3EEFCFF78CAF2FF74C8F1FF72C5F0FF6FC4F0FF6DC2
      EFFF69C0EEFF66BDEEFF63BBEDFF60B9EBFF408ACAFF112C4E81327CBFFFAFE3
      F5FF75C8EDFF55A3D7FFD2F5FDFFD4F6FEFFD2F4FEFFCDF3FDFFC8F1FDFFC2EE
      FCFFBCEBFBFFB5E7FAFFADE3F9FFA5DFF8FF82C0E6FF1E5189CB3582C4FFC7F5
      FEFF97E5FCFF62BBE7FF4AA0D6FF4A9DD5FF91C3E3FF8DBCDCFF8FBDE0FF5FA3
      D6FF4394CFFF4292CEFF2D73BAFF2D72B9FF2C71B8FF2765A7EA3688C8FFCDF7
      FEFFA6ECFEFF9CE8FDFF93E4FBFF8EE1FBFFBBE6F3FFA68E78FFA6BABDFFB2E1
      F3FFB9E6F7FFB3E0F0FF8EADD1FF000000180000000B00000007398ECBFFD0F8
      FEFFAEF0FEFFAAEEFEFFA6EDFEFFA5EBFDFFD3EDF3FFAD744CFF9A6841FFBEB8
      ADFFD1E1E3FF975D32FF8A6E59FF0C07032E00000007000000013B92CEFFD3F9
      FEFFB6F3FEFFB3F1FDFFB0F1FEFFB8EDFAFF9CC3E0FFAD886CFFDBB891FFB07F
      53FF9B643AFF9F663DFFDBB67EFF8E5D33EF311D0F67000000063D97D1FFE2FC
      FEFFE2FCFEFFE1FCFEFFD3F3FAFF428FC1EC0B111523382A1E58C49870FFEAD2
      B1FFFCF0D0FFFEF2D3FFFEE9BBFFF7E6C5FFA36C43FF000000082E739DBF3E9A
      D3FF3E99D3FF3E99D3FF3E97D2FF143245590000000200000003382C204E9877
      58CABF946DFAC3966DFFEAD3B4FFB7906CEE3D2E215B00000003000000020000
      0003000000030000000400000003000000020000000000000000000000010000
      000200000005CAA27AFF846A50AC110D0A1B0000000200000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000100000001000000000000000000000000}
    TabOrder = 12
    OnClick = btnExportarClick
  end
  inline DirectoryEditFocus: TfraDirectoryEditFocus [20]
    Left = 8
    Top = 199
    Width = 540
    Height = 24
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 9
    ExplicitLeft = 8
    ExplicitTop = 199
    ExplicitWidth = 540
    ExplicitHeight = 24
  end
  inherited pnlStatus: TPanel [21]
    Top = 259
    Width = 560
    ExplicitTop = 260
    ExplicitWidth = 560
    inherited pnlNomeForm: TPanel
      Left = 389
      ExplicitLeft = 389
    end
    inherited pnlInfo: TPanel
      Width = 389
      ExplicitWidth = 389
    end
  end
  inherited mnuAuxiliar: TPopupMenu [22]
    Left = 904
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents [23]
    Left = 872
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade [24]
    Left = 808
    Top = 56
  end
end
