inherited frmCfgFilasImpressaoSeparacao: TfrmCfgFilasImpressaoSeparacao
  Left = 299
  Top = 188
  Width = 854
  Height = 530
  BorderIcons = [biSystemMenu]
  Caption = 'Filas de Impress'#227'o Separa'#231#227'o (Or'#231'amentos e Pedidos de Venda)'
  Position = poMainFormCenter
  ExplicitWidth = 854
  ExplicitHeight = 530
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 485
    Width = 848
    TabOrder = 3
    ExplicitTop = 485
    ExplicitWidth = 848
    DesignSize = (
      848
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 844
      ExplicitWidth = 844
    end
  end
  inherited pnlStatus: TPanel
    Top = 485
    Width = 848
    ExplicitTop = 485
    ExplicitWidth = 848
    inherited pnlNomeForm: TPanel
      Left = 677
      ExplicitLeft = 677
    end
    inherited pnlInfo: TPanel
      Width = 677
      ExplicitWidth = 677
    end
  end
  inherited pgcDados: TPageControl
    Width = 651
    Height = 1
    ActivePage = nil
    Align = alNone
    Visible = False
    ExplicitWidth = 651
    ExplicitHeight = 1
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 643
      ExplicitHeight = 428
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 848
    Height = 188
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label1: TLabel
      Left = 35
      Top = 39
      Width = 87
      Height = 14
      Caption = 'Fila de Impress'#227'o:'
    end
    object Label2: TLabel
      Left = 70
      Top = 16
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 7
      Top = 84
      Width = 115
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o Where (SQL):'
    end
    object spbShowSQL: TSpeedButton
      Left = 606
      Top = 57
      Width = 107
      Height = 22
      Caption = 'Visualizar SQL'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
        00000000000100000004000000090000000D0000000F0000000F0000000C0000
        00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
        0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
        1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
        02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
        50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
        3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
        C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
        7CFFEFE6DFFFCDA67CFFCDA26BFFE3C28CFFEDD5A2FFE7CD9EFFD3B182FFD0AE
        88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
        C9FFDDC1A8FFC99865FFE8BE83FFE9C388FFEDCA97FFEFD3A7FFF2D9B0FFD5B1
        87FFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
        F2FFC79873FFDEAB77FFEFCDABFFF0D0B1FFEDC9A1FFECC69AFFEFCFA9FFE9C9
        A4FFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
        FCFFBE875FFFEDCFB9FFF5DFD2FFF2D6C1FFF1CFB4FFEDC6A4FFECC19BFFEFC8
        A6FFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
        F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FFF3D4C2FFF0CBB2FFEBB78EFFE5B7
        92FFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
        D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FFF6DDD3FFF1C8B2FFEBAF88FFC98E
        6CFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
        A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88865FFCE9D
        84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
        4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
        F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
        020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
        A2FC62504B900404031000000002000000000000000000000000000000000000
        000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
        1F3E000000060000000100000000000000000000000000000000}
      OnClick = spbShowSQLClick
    end
    object btnSelImp: TSpeedButton
      Left = 603
      Top = 33
      Width = 27
      Height = 22
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
      ParentShowHint = False
      ShowHint = False
      Visible = False
      OnClick = btnSelImpClick
    end
    object lblLayout: TLabel
      Left = 86
      Top = 59
      Width = 36
      Height = 14
      Caption = 'Layout:'
    end
    object Label5: TLabel
      Left = 33
      Top = 164
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome da M'#225'quina:'
    end
    object edtNomImp: TEditFocus
      Tag = 99
      Left = 125
      Top = 33
      Width = 477
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 255
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnInserir: TBitBtnLocked
      Left = 608
      Top = 153
      Width = 75
      Height = 25
      Caption = '&Inserir'
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
      TabOrder = 6
      OnClick = btnInserirClick
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 125
      Top = 10
      Width = 477
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 255
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object memWhere: TMemo
      Tag = 99
      Left = 125
      Top = 79
      Width = 477
      Height = 78
      TabOrder = 4
      OnEnter = memWhereEnter
      OnKeyPress = memWhereKeyPress
    end
    object edtCodLay: TEditFocus
      Tag = 99
      Left = 125
      Top = 56
      Width = 76
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 6
      TabOrder = 3
      OnKeyPress = edtCodLayKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesLay: TEditFocus
      Tag = 99
      Left = 203
      Top = 56
      Width = 399
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      MaxLength = 255
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbNomMaq: TComboBoxFocus
      Left = 125
      Top = 158
      Width = 208
      Height = 22
      Style = csDropDownList
      BiDiMode = bdLeftToRight
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object ckbSolicitarImpressora: TCheckBox
      Left = 605
      Top = 12
      Width = 113
      Height = 17
      Caption = 'Solicitar Impressora'
      TabOrder = 1
      OnClick = ckbSolicitarImpressoraClick
    end
  end
  object dbgFilImp: TDBGridCitel [4]
    Left = 0
    Top = 188
    Width = 848
    Height = 297
    Align = alClient
    DataSource = dtsFilImp
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgFilImpDrawColumnCell
    OnDblClick = dbgFilImpDblClick
    OnKeyDown = dbgFilImpKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'FIL_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 347
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIL_NOMIMP'
        Title.Caption = 'Fila de Impress'#227'o'
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIL_CODLAY'
        Title.Caption = 'C'#243'd. Layout'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIL_NOMMAQ'
        Title.Caption = 'Nome da M'#225'quina'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIL_SOLIMP'
        Title.Caption = 'Solicitar Impressora'
        Width = 100
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 528
    Top = 352
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 552
    Top = 328
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 624
    Top = 344
  end
  object dtsFilImp: TDataSource
    DataSet = cdsFilImp
    Left = 504
    Top = 304
  end
  object cdsFilImp: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 600
    Top = 280
  end
  object dspFilImp: TUniDataSetProvider
    Options = []
    Left = 504
    Top = 304
  end
end
