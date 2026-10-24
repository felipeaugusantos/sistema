inherited frmCadPrevisao: TfrmCadPrevisao
  Width = 660
  Height = 450
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Previs'#245'es'
  ExplicitWidth = 660
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 367
    Width = 644
    ExplicitTop = 367
    ExplicitWidth = 644
    DesignSize = (
      644
      28)
    object Label1: TLabel [0]
      Left = 381
      Top = 5
      Width = 121
      Height = 17
      Caption = '[DELETE] - Excluir'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial Black'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 640
      ExplicitTop = 2
      ExplicitWidth = 640
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 115
        ExplicitWidth = 115
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 115
        Width = 115
        ExplicitLeft = 115
        ExplicitWidth = 115
      end
      object btnConfirmar: TBitBtnLocked
        Left = 230
        Top = 0
        Width = 115
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 2
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 565
      ExplicitLeft = 565
    end
  end
  inherited pnlHeader: TPanel
    Width = 644
    Height = 70
    ExplicitWidth = 644
    ExplicitHeight = 70
    object gpb2: TGroupBox
      Left = 170
      Top = 0
      Width = 475
      Height = 65
      TabOrder = 1
      object lbl4: TLabel
        Left = 339
        Top = 16
        Width = 38
        Height = 14
        Caption = 'Esp'#233'cie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl3: TLabel
        Left = 5
        Top = 16
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 5
        Top = 30
        Width = 50
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtEspDoc: TEditFocus
        Tag = 99
        Left = 339
        Top = 30
        Width = 50
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfabetico
      end
      object edtDesEmp: TEditFocus
        Left = 57
        Top = 30
        Width = 280
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnCarregar: TBitBtnLocked
        Left = 390
        Top = 30
        Width = 82
        Height = 22
        Caption = 'Carregar'
        TabOrder = 3
        OnClick = btnCarregarClick
      end
    end
    object gpb1: TGroupBox
      Left = 6
      Top = 0
      Width = 159
      Height = 65
      Caption = 'Per'#237'odo'
      TabOrder = 0
      object lbl1: TLabel
        Left = 5
        Top = 21
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
        Left = 9
        Top = 42
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
      object mskDtaIni: TcxDateEdit
        Tag = 99
        Left = 57
        Top = 12
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.SourceHeight = 16
        Properties.ButtonGlyph.SourceWidth = 16
        Properties.ButtonGlyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000018744558745469746C6500546F6461793B43616C656E6461723B4461
          79DFD0E0E20000022B49444154785E85533D6B1451143D932CC1C2B5F0276815
          DD28422C2C92C6D5E04722F10315C19F606561AA58AC8895A59FE5AA58ACA218
          35A01626984870936C0411B49744D14D369BDD99FBDE78DE7D8F59D4C2650EE7
          BEFBEE3DF7637622000EDD4417C22FF890E15F7F4A5842722EF9EDA9E1D75418
          B4D6C2DA148E53C210EA33DE4E1D1B1F138B4C9D999D2BAA402EC260EFE821EA
          FA64660086B60893681346C88415772F9879FA6A40730144364D35B0F5E5B317
          30BE2A7D046DCF99DDBD39CF5A7EA49C0EE4DA8E63185751B47DB2091CC41C6C
          F025E4D46602D1E2F112F69DDE8D3C85E09E08CA20A7A114E12F227F7EF67001
          78DF1F75B9301155D3E0AFD72EA376FE04E6CF8DA27A76049FC62FC115BB7D7F
          16DF565671B33CA34B4C12A31D0401D192F463F5630D2671CB13180AAF7C9883
          A1F091FD3B94870FEC24670270023C584DD6654A02630C0AE527B0148A375AEA
          7F3CB9A49D549ED760ADE67476908884570888F885554F1E66501BED769B82C0
          48B1A0958F0DF58511A43342121BDD99E1454F6F01EB8D26EAF59FF855AF23BF
          67AF765079B948761D2C8411A4D3010F4E4095B78F95B00D7AA73EDF192B1FEC
          43EA786817ACC19F3B887960902ADF7DF00ECB3F1AB8736F1ACBDFD770AB4CE6
          F9D1C4BCC65426AADA91841D4400B65C187F51BF3A5644A3A9A3E8BBF6062933
          3343A974FD0D6E5C39BAD58D20CDE6DAD4C5D2E400A37D4C08ECFCAB327F66C7
          ADF5694751186313D1F3D7671CFDE7738E898DDFA483B27117D9EAF600000000
          49454E44AE426082}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        TabOrder = 0
        Width = 98
      end
      object mskDtaFin: TcxDateEdit
        Tag = 99
        Left = 57
        Top = 38
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.SourceHeight = 16
        Properties.ButtonGlyph.SourceWidth = 16
        Properties.ButtonGlyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000018744558745469746C6500546F6461793B43616C656E6461723B4461
          79DFD0E0E20000022B49444154785E85533D6B1451143D932CC1C2B5F0276815
          DD28422C2C92C6D5E04722F10315C19F606561AA58AC8895A59FE5AA58ACA218
          35A01626984870936C0411B49744D14D369BDD99FBDE78DE7D8F59D4C2650EE7
          BEFBEE3DF7637622000EDD4417C22FF890E15F7F4A5842722EF9EDA9E1D75418
          B4D6C2DA148E53C210EA33DE4E1D1B1F138B4C9D999D2BAA402EC260EFE821EA
          FA64660086B60893681346C88415772F9879FA6A40730144364D35B0F5E5B317
          30BE2A7D046DCF99DDBD39CF5A7EA49C0EE4DA8E63185751B47DB2091CC41C6C
          F025E4D46602D1E2F112F69DDE8D3C85E09E08CA20A7A114E12F227F7EF67001
          78DF1F75B9301155D3E0AFD72EA376FE04E6CF8DA27A76049FC62FC115BB7D7F
          16DF565671B33CA34B4C12A31D0401D192F463F5630D2671CB13180AAF7C9883
          A1F091FD3B94870FEC24670270023C584DD6654A02630C0AE527B0148A375AEA
          7F3CB9A49D549ED760ADE67476908884570888F885554F1E66501BED769B82C0
          48B1A0958F0DF58511A43342121BDD99E1454F6F01EB8D26EAF59FF855AF23BF
          67AF765079B948761D2C8411A4D3010F4E4095B78F95B00D7AA73EDF192B1FEC
          43EA786817ACC19F3B887960902ADF7DF00ECB3F1AB8736F1ACBDFD770AB4CE6
          F9D1C4BCC65426AADA91841D4400B65C187F51BF3A5644A3A9A3E8BBF6062933
          3343A974FD0D6E5C39BAD58D20CDE6DAD4C5D2E400A37D4C08ECFCAB327F66C7
          ADF5694751186313D1F3D7671CFDE7738E898DDFA483B27117D9EAF600000000
          49454E44AE426082}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        TabOrder = 1
        Width = 98
      end
    end
  end
  inherited pnlTail: TPanel
    Top = 339
    Width = 644
    Height = 28
    TabOrder = 4
    ExplicitTop = 339
    ExplicitWidth = 644
    ExplicitHeight = 28
    object btnCopiarDescri: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 135
      Height = 22
      Caption = '[ F8 ] Copiar Descri'#231#227'o'
      TabOrder = 0
      OnClick = btnCopiarDescriClick
    end
    object btnCopiarValPag: TBitBtnLocked
      Left = 140
      Top = 3
      Width = 135
      Height = 22
      Caption = '[ F9 ] Copiar Vlr. Pagar'
      TabOrder = 1
      OnClick = btnCopiarValPagClick
    end
    object btnCopiarValRec: TBitBtnLocked
      Left = 276
      Top = 3
      Width = 135
      Height = 22
      Caption = '[ F11 ] Copiar Vlr. Receber'
      TabOrder = 2
      OnClick = btnCopiarValRecClick
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 110
    Width = 644
    Height = 229
    TabStop = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    OnKeyDown = dbgConsultaKeyDown
    OnKeyPress = dbgConsultaKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'DTALAN'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Data'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEMP'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Emp.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESPDOC'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Esp.'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRI'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o'
        Width = 275
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALPAG'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total a Pagar'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALREC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total a Receber'
        Width = 100
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 70
    Width = 644
    ExplicitTop = 70
    ExplicitWidth = 644
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Left = 300
      Top = 9
      Width = 267
      ExplicitLeft = 300
      ExplicitTop = 9
      ExplicitWidth = 267
    end
    inherited edtValor: TEditFocus
      Left = 566
      Top = 9
      ExplicitLeft = 566
      ExplicitTop = 9
    end
  end
  inherited pnlStatus: TPanel
    Top = 395
    Width = 644
    ExplicitTop = 395
    ExplicitWidth = 644
    inherited pnlNomeForm: TPanel
      Left = 473
      ExplicitLeft = 473
    end
    inherited pnlInfo: TPanel
      Width = 473
      ExplicitWidth = 473
      object pbProgresso: TProgressBar
        Left = 2
        Top = 2
        Width = 469
        Height = 12
        Align = alClient
        TabOrder = 0
        Visible = False
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 224
  end
  inherited qryConsulta: TUniQuery
    Left = 216
    Top = 224
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 248
    Top = 224
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 280
    Top = 224
  end
  inherited dtsConsulta: TDataSource
    DataSet = cdsPrevisoes
    Left = 312
    Top = 224
  end
  object cdsPrevisoes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    AfterInsert = cdsPrevisoesAfterInsert
    Left = 280
    Top = 192
    object cdsPrevisoesDTALAN: TDateField
      FieldName = 'DTALAN'
    end
    object cdsPrevisoesHORLAN: TTimeField
      FieldName = 'HORLAN'
    end
    object cdsPrevisoesVALPAG: TFloatField
      FieldName = 'VALPAG'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object cdsPrevisoesVALREC: TFloatField
      FieldName = 'VALREC'
      DisplayFormat = ',0.00'
      EditFormat = ',0.00'
    end
    object cdsPrevisoesESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsPrevisoesCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsPrevisoesDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 50
    end
  end
end
