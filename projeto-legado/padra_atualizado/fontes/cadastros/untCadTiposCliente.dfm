inherited frmCadTiposCliente: TfrmCadTiposCliente
  Left = 248
  Top = 192
  Width = 686
  Height = 580
  Caption = 'Tipos de Cliente'
  ExplicitWidth = 686
  ExplicitHeight = 580
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 510
    Width = 680
    Height = 25
    TabOrder = 1
    ExplicitTop = 510
    ExplicitWidth = 680
    ExplicitHeight = 25
    DesignSize = (
      680
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 676
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 676
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 76
        ExplicitWidth = 76
      end
      inherited btnGravar: TBitBtnLocked
        Left = 76
        Width = 76
        ExplicitLeft = 76
        ExplicitWidth = 76
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 152
        Width = 76
        ExplicitLeft = 152
        ExplicitWidth = 76
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 228
        Width = 76
        ExplicitLeft = 228
        ExplicitWidth = 76
      end
      inherited btnCancela: TBitBtnLocked
        Left = 304
        Width = 76
        ExplicitLeft = 304
        ExplicitWidth = 76
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 380
        Width = 76
        ExplicitLeft = 380
        ExplicitWidth = 76
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 605
      Width = 72
      Height = 20
      Align = alRight
      ExplicitLeft = 605
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 680
    Height = 510
    ExplicitWidth = 680
    ExplicitHeight = 510
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 672
      ExplicitHeight = 478
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 680
    Height = 510
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 680
      Height = 54
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 7
        Top = 12
        Width = 86
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 7
        Top = 35
        Width = 86
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Descri'#231#227'o:'
      end
      object dbeCodTip: TDBEditFocus
        Tag = 99
        Left = 96
        Top = 8
        Width = 49
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TIP_CODTIP'
        DataSource = dtsTipClg
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDesTip: TDBEditFocus
        Tag = 99
        Left = 96
        Top = 31
        Width = 569
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TIP_DESTIP'
        DataSource = dtsTipClg
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlDadosFpg: TPanel
      Left = 0
      Top = 80
      Width = 680
      Height = 25
      Align = alTop
      Color = 16770261
      TabOrder = 2
      object Label3: TLabel
        Left = 7
        Top = 9
        Width = 86
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Forma de Pagto:'
      end
      object edtCodFpg: TEditFocus
        Tag = 99
        Left = 96
        Top = 2
        Width = 45
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodFpgKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesFpg: TEditFocus
        Left = 141
        Top = 2
        Width = 524
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    end
    object dbgTipos: TDBGridCitel
      Left = 0
      Top = 280
      Width = 680
      Height = 198
      Align = alClient
      DataSource = dtsConsulta
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 5
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgTiposKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'TIP_CODFPG'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIP_DESFPG'
          Title.Caption = 'Descri'#231#227'o'
          Width = 400
          Visible = True
        end>
    end
    object pnlCndPag: TPanel
      Left = 0
      Top = 54
      Width = 680
      Height = 26
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lbl1: TLabel
        Left = 4
        Top = 5
        Width = 86
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Cnd. Pagamento:'
      end
      object mskCndPag: TMaskEditFocus
        Tag = 99
        Left = 141
        Top = 2
        Width = 524
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;_'
        MaxLength = 98
        ReadOnly = True
        TabOrder = 1
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodCnd: TEditFocus
        Tag = 99
        Left = 96
        Top = 2
        Width = 45
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodCndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlConfirma: TPanel
      Left = 0
      Top = 105
      Width = 680
      Height = 30
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object lbl2: TLabel
        Left = 4
        Top = 14
        Width = 136
        Height = 14
        Caption = 'Condi'#231#227'o de Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnConfirmar: TBitBtnLocked
        Left = 438
        Top = 3
        Width = 111
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnCancelaFpg: TBitBtnLocked
        Left = 555
        Top = 3
        Width = 111
        Height = 22
        Caption = 'C&ancelar'
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
        TabOrder = 1
        OnClick = btnCancelaFpgClick
      end
    end
    object dbgTipCnd: TDBGridCitel
      Left = 0
      Top = 135
      Width = 680
      Height = 128
      Align = alTop
      DataSource = dtsTipCnd
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 4
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnKeyDown = dbgTipCndKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'TCN_CODCND'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TCN_CNDPAG'
          Title.Caption = 'Condi'#231#227'o de Pagamento'
          Width = 290
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CND_DESCRI'
          Title.Caption = 'Descri'#231#227'o da Condi'#231#227'o de Pagamento'
          Width = 290
          Visible = True
        end>
    end
    object pnl3: TPanel
      Left = 0
      Top = 263
      Width = 680
      Height = 17
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 6
      object lbl3: TLabel
        Left = 5
        Top = 1
        Width = 120
        Height = 14
        Caption = 'Forma de Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnl1: TPanel
      Left = 0
      Top = 478
      Width = 680
      Height = 32
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 7
      object lbl4: TLabel
        Left = 5
        Top = 1
        Width = 385
        Height = 14
        Caption = 
          '[ F3 ] Alterna entre Lista / Campo digita'#231#227'o da condi'#231#227'o de paga' +
          'mento.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 5
        Top = 16
        Width = 369
        Height = 14
        Caption = 
          '[ F4 ] Alterna entre Lista / Campo digita'#231#227'o da forma de pagamen' +
          'to.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 535
    Width = 680
    TabOrder = 3
    ExplicitTop = 535
    ExplicitWidth = 680
    inherited pnlNomeForm: TPanel
      Left = 524
      Width = 156
      ExplicitLeft = 524
      ExplicitWidth = 156
    end
    inherited pnlInfo: TPanel
      Width = 524
      ExplicitWidth = 524
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 488
    Top = 176
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 184
    Top = 347
  end
  object dtsConsulta: TDataSource
    Left = 280
    Top = 347
  end
  object dtsTipClg: TDataSource
    Left = 408
    Top = 168
  end
  object dtsTipCnd: TDataSource
    Left = 328
    Top = 200
  end
end
