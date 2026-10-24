inherited frmCancelaLocEqu: TfrmCancelaLocEqu
  Width = 822
  Height = 520
  Caption = 'Cancelamento de Loca'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 822
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 447
    Width = 816
    ExplicitTop = 447
    ExplicitWidth = 816
    inherited FlwBotoes: TFlowPanel
      Width = 812
      ExplicitWidth = 812
    end
    inherited btnSair: TBitBtnLocked
      Left = 733
      ExplicitLeft = 733
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 816
    ExplicitTop = 475
    ExplicitWidth = 816
    inherited pnlNomeForm: TPanel
      Left = 645
      ExplicitLeft = 645
    end
    inherited pnlInfo: TPanel
      Width = 645
      ExplicitWidth = 645
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 816
    Height = 36
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    object lblNumCon: TLabel
      Left = 185
      Top = 9
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblNumPed: TLabel
      Left = 35
      Top = 9
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 287
      Top = 6
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 1
      OnKeyPress = edtNumConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
    object edtNumPed: TEditFocus
      Tag = 99
      Left = 76
      Top = 6
      Width = 95
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnKeyPress = edtNumPedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
  end
  object pnlDadosContrato: TPanel [3]
    Left = 0
    Top = 36
    Width = 816
    Height = 85
    Align = alTop
    TabOrder = 3
    object lblCodCli: TLabel
      Left = 14
      Top = 11
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object lblCodVen: TLabel
      Left = 14
      Top = 35
      Width = 50
      Height = 14
      Caption = 'Vendedor:'
    end
    object lblEntCli: TLabel
      Left = 14
      Top = 59
      Width = 61
      Height = 14
      Caption = 'Localiza'#231#227'o:'
    end
    object edtLocalizacao: TEditFocus
      Tag = 99
      Left = 78
      Top = 56
      Width = 581
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Tag = 99
      Left = 144
      Top = 8
      Width = 515
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
    object edtNomVen: TEditFocus
      Tag = 99
      Left = 144
      Top = 32
      Width = 515
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 78
      Top = 8
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 78
      Top = 32
      Width = 64
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 67
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
  end
  object pnlTituloDocumentosEmitidos: TPanel [4]
    Left = 0
    Top = 153
    Width = 816
    Height = 23
    Align = alTop
    Alignment = taLeftJustify
    Caption = '  Documentos Emitidos'
    TabOrder = 4
  end
  object pnlDocumentosEmitidos: TPanel [5]
    Left = 0
    Top = 176
    Width = 816
    Height = 271
    Align = alClient
    TabOrder = 5
    object cxGridDocumentosEmitidos: TcxGridCitel
      Left = 1
      Top = 1
      Width = 814
      Height = 269
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridDocumentosEmitidosView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxGridDocumentosEmitidosViewCustomDrawCell
        DataController.DataSource = dtsEqlFat
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.ShowEditButtons = gsebAlways
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridDocumentosEmitidosViewEQF_NUMDOC: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'EQF_NUMDOC'
          Options.Editing = False
        end
        object cxGridDocumentosEmitidosViewEQF_ESPDOC: TcxGridDBColumn
          Caption = 'Esp'#233'cie'
          DataBinding.FieldName = 'EQF_ESPDOC'
          Options.Editing = False
          Width = 56
        end
        object cxGridDocumentosEmitidosViewEQF_EMPDOC: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'EQF_EMPDOC'
          Options.Editing = False
          Width = 57
        end
        object cxGridDocumentosEmitidosViewEQF_DTAFAT: TcxGridDBColumn
          Caption = 'Data Emiss'#227'o'
          DataBinding.FieldName = 'EQF_DTAFAT'
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Width = 73
        end
        object cxGridDocumentosEmitidosViewEQF_HRAFAT: TcxGridDBColumn
          Caption = 'Hora emiss'#227'o'
          DataBinding.FieldName = 'EQF_HRAFAT'
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Width = 76
        end
        object cxGridDocumentosEmitidosViewEQF_VALFAT: TcxGridDBColumn
          Caption = 'Valor Faturado'
          DataBinding.FieldName = 'EQF_VALFAT'
          Options.Editing = False
          Width = 102
        end
        object cxGridDocumentosEmitidosViewBTNCANCELAR: TcxGridDBColumn
          Caption = 'Cancelar Documento'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Buttons = <
            item
              Caption = 'Cancelar'
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                610000005A744558745469746C650044656C6574653B44656C6574654974656D
                3B52656D6F76653B52656D6F76654974656D3B44656C6574654C6973743B4C69
                73743B52656D6F76654C6973743B4974656D3B4C6973743B436C6561723B4572
                61736558E2170B0000025A49444154785E75514D68135110FEDE26246DB45A25
                956890A6554B4CD14320280A9A6A405B7F5A512A4A5BF1E045AC41AB3978E925
                15A445945E04ED45F1A7880729A4C550C1A306AA3DB40715C5D2B4B056441375
                93ECBEE7CE23592236B3CC0E3BF3ED3733DF3021041863CADDD1B7934C616190
                0980F20220B75E020CBCA0BF3ADF1DDA6FD60DCADA210DECE7AF42F8F2D910CA
                F0CBDAD0C89BBD84A74439010C43400840CBE9B22E2C16062A0806B8AAEC268E
                633902661806C89E25DFCB6139ADC1CD683A3DD98C86DEEE100C5E81205F30E4
                DEC7224DB231B7F6A6202791B97C4EAF4090D7256074625676169244AA29F399
                AC86E8991D205C050DB89CE078C40FABB760148B9A48D29206F86F024E04009E
                2466A8A32562F366371ABCABF0FD8706FFA63A9C68F563F01AEC747A005CF9E7
                0A1CE86C0DE024795B003DEDDBB0DDF60D467F0C6B934F51D07EC335F608EF0E
                B47D4886F7450028D6043AE7A0191E8ECD94DAE370B8117F6E0FC377AE03D9D9
                8FF87CA117753B035879A9CB938DDF1B01D06069205710C0A943CDE045826AA7
                822FF5F5584ABE803BE887AFB3054A46C562621C69F5EB64B906746FF9A3D369
                A384A581371AC5D4E91E93CCACAD7621935E422A3195BEB930D757AE012FE4B4
                97B1F804AE163D161F476A7A0ED3FDD7E1DB1580DD6143E6D33C1C5536048FEE
                F15E746F1C0260A3F394EEEA00E002B0A2CCD73C6F0AAAEA4054A43A5AC41D4F
                E3C2EB83BBC5FC952E71ABD6BB08C04904159D3A0CAFDF72E4B177AB3A58BBE1
                BEDFEE5C3750E37970A3C6A3F655BBDB490246C04AC64C03A014B522A041A4C5
                9C4EDF7F01B0BA3D657982DCCC0000000049454E44AE426082}
              Kind = bkGlyph
            end>
          Properties.MaxLength = 0
          Properties.ViewStyle = vsButtonsOnly
          Properties.OnButtonClick = cxGridDocumentosEmitidosViewColumn1PropertiesButtonClick
          Width = 106
        end
        object cxGridDocumentosEmitidosViewEQF_STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'EQF_STATUS'
          MinWidth = 30
          Options.Editing = False
        end
        object cxGridDocumentosEmitidosViewEQF_STRSTA: TcxGridDBColumn
          DataBinding.FieldName = 'EQF_STRSTA'
          Visible = False
        end
      end
      object cxGridDocumentosEmitidosLeve1: TcxGridLevel
        GridView = cxGridDocumentosEmitidosView
      end
    end
  end
  object pnlDuracaoContrato: TPanel [6]
    Left = 0
    Top = 121
    Width = 816
    Height = 32
    Align = alTop
    TabOrder = 6
    object lblInicio: TLabel
      Left = 190
      Top = 9
      Width = 27
      Height = 14
      Caption = 'In'#237'cio:'
    end
    object lblTermino: TLabel
      Left = 352
      Top = 9
      Width = 41
      Height = 14
      Caption = 'T'#233'rmino:'
    end
    object Label1: TLabel
      Left = 14
      Top = 9
      Width = 151
      Height = 14
      Caption = 'Duracao Estimada  do contrato:'
    end
    object edtDtaIni: TDBEditFocus
      Tag = 99
      Left = 223
      Top = 5
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EQL_DTAINI'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtHorIni: TDBEditFocus
      Tag = 99
      Left = 289
      Top = 5
      Width = 40
      Height = 22
      Color = 16768952
      DataField = 'EQL_HORINI'
      Enabled = False
      MaxLength = 5
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDtaFin: TDBEditFocus
      Tag = 99
      Left = 399
      Top = 5
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'EQL_DTAFIN'
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtHorFin: TDBEditFocus
      Tag = 99
      Left = 465
      Top = 5
      Width = 40
      Height = 22
      Color = 16768952
      DataField = 'EQL_HORFIN'
      Enabled = False
      MaxLength = 5
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 664
    Top = 248
  end
  object cdsEqlFat: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'EQF_SEQCON'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQF_NUMDOC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQF_ESPDOC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQF_SERDOC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQF_VALFAT'
        DataType = ftFloat
      end
      item
        Name = 'EQF_EMPDOC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EQF_DTAFAT'
        DataType = ftDateTime
      end
      item
        Name = 'EQF_STATUS'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'EQF_HRAFAT'
        DataType = ftDateTime
      end
      item
        Name = 'EQF_STRSTA'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Top = 284
    object cdsEqlFatEQF_SEQCON: TStringField
      FieldName = 'EQF_SEQCON'
    end
    object cdsEqlFatEQF_NUMDOC: TStringField
      FieldName = 'EQF_NUMDOC'
    end
    object cdsEqlFatEQF_ESPDOC: TStringField
      FieldName = 'EQF_ESPDOC'
    end
    object cdsEqlFatEQF_SERDOC: TStringField
      FieldName = 'EQF_SERDOC'
    end
    object cdsEqlFatEQF_VALFAT: TFloatField
      FieldName = 'EQF_VALFAT'
    end
    object cdsEqlFatEQF_EMPDOC: TStringField
      FieldName = 'EQF_EMPDOC'
    end
    object cdsEqlFatEQF_DTAFAT: TDateTimeField
      Alignment = taCenter
      FieldName = 'EQF_DTAFAT'
    end
    object cdsEqlFatEQF_STATUS: TStringField
      DisplayWidth = 40
      FieldName = 'EQF_STATUS'
      Size = 50
    end
    object cdsEqlFatEQF_HRAFAT: TDateTimeField
      Alignment = taCenter
      FieldName = 'EQF_HRAFAT'
    end
    object cdsEqlFatEQF_STRSTA: TStringField
      FieldName = 'EQF_STRSTA'
    end
  end
  object dtsEqlFat: TUniDataSource
    DataSet = cdsEqlFat
    Left = 144
    Top = 284
  end
  object imgButton: TImageList
    Left = 232
    Top = 290
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000884
      BD0031ADD60042B5DE0039B5D60021A5D60031ADD60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000088CBD00108C
      C60063CEEF0084D6FF007BD6F7007BD6F70063C6E7005ABDE70031ADD6000000
      00000000000000000000000000000000000018427B00215AA500215AA500215A
      A500215AA500215AA500215AA500215AA5002152A5002152A5002152A5002152
      A5002152A50018428C0000080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001094C600189C
      CE006BCEEF008CDEFF007BD6F70063CEEF0042B5D60073CEF70084D6FF005ABD
      E70000000000000000000000000000000000215AA500316BAD006BA5D60084CE
      F70042A5E70042A5E70042A5E70039A5E700399CE700399CE700399CE700319C
      E700319CDE002973C60010294A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0021A5
      CE007BD6F7009CE7FF008CDEFF0042B5DE000884B50052BDDE007BD6F70084D6
      FF00189CCE00000000000000000000000000296BAD004A84BD004A8CC600B5E7
      FF006BBDEF0052B5EF0052ADEF004AADE7004AADE7004AADE70042A5E70042A5
      E70042A5E7003994D600184A8400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A5CE0029AD
      D6009CE7FF00B5EFFF00A5E7FF0052BDDE00087BAD004ABDDE007BD6F7007BD6
      F700189CCE00000000000000000000000000296BB5006BA5D6003984C600ADDE
      F7009CDEF70063BDEF0063BDEF0063BDEF005AB5EF005AB5EF0052B5EF0052B5
      EF0052ADE7004AADE700296BB500000810000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021A5D60031AD
      D600B5E7F700B5EFFF00B5EFFF00A5E7FF001094C6005AC6E70084D6FF0073CE
      F700189CCE000000000000000000000000003173BD008CC6E700529CD60084BD
      E700C6EFFF007BCEF70073CEF70073C6F7006BC6F7006BC6EF006BC6EF0063BD
      EF0063BDEF0063BDEF00428CCE0010294A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0031AD
      D60042B5D6004ABDDE0042B5DE0042B5DE005ABDE7006BCEEF0084D6FF008CDE
      FF00189CCE00000000000000000000000000317BBD00ADE7F70073CEEF005AA5
      D600DEF7FF00DEFFFF00DEF7FF00DEF7FF00DEF7FF00D6F7FF00D6F7FF00CEEF
      FF00C6EFFF00C6EFFF009CCEEF00215284000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0042B5
      D60021A5D60031ADD60031ADD60021A5CE0031ADD6005ABDE70084D6FF006BCE
      EF001094C6000000000000000000000000003984C600C6F7FF0094E7FF0063BD
      E7004A9CD6004A9CD6004A9CD6004A9CCE004A9CCE004A94CE004294CE004294
      CE003173B5003173B5002973B5002963A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000189CCE0042B5
      D6000884B50021A5CE007BD6F70039B5D60021A5CE000884BD001094C60039B5
      D600108CC600000000000000000000000000398CC600CEF7FF00A5EFFF009CEF
      FF0094E7FF008CE7FF008CDEFF0084DEFF0084DEFF007BDEFF007BD6FF007BD6
      FF00296BB5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000087B
      AD00087BAD00189CC6007BD6F7007BD6F70031ADD600087BAD000884B500108C
      C60000000000000000000000000000000000398CCE00D6FFFF00ADF7FF00ADEF
      FF00A5EFFF00A5EFFF00BDF7FF00D6FFFF00D6FFFF00D6FFFF00D6FFFF00CEF7
      FF003184BD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000884B5000884B5000000000021A5D600108CC600087BAD00087BAD000000
      0000000000000000000000000000000000003994CE00D6FFFF00B5F7FF00B5F7
      FF00B5F7FF00BDEFFF004A94CE00398CC600398CC600398CC600398CC6003984
      C600296394000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039B5D6000884BD00000000000000000000000000087BAD00087BAD000000
      0000000000000000000000000000000000004294CE00E7FFFF00E7FFFF00E7FF
      FF00D6F7FF00428CBD0000080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000108CC60063CEEF00189CC60000000000087BAD000884BD00000000000000
      00000000000000000000000000000000000031739C00429CD600429CD600429C
      D6004294CE001031420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000018A5CE0063C6E70052BDDE0031ADD6000884B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000E07FFFFF00000000
      C01F000100000000C00F000100000000C007000100000000C007000000000000
      C007000000000000C007000000000000C007000000000000C007000700000000
      E00F000700000000F21F000700000000F39F01FF00000000F13F03FF00000000
      F83FFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
