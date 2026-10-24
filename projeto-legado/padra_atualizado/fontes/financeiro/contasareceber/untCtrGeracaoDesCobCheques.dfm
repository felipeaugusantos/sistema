inherited frmCtrGeracaoDesCobCheques: TfrmCtrGeracaoDesCobCheques
  Width = 859
  Height = 548
  Caption = 'Gera'#231#227'o de Despesas de Cobran'#231'a para Cheques Devolvidos'
  Position = poMainFormCenter
  ExplicitTop = -25
  ExplicitWidth = 859
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 477
    Width = 853
    Height = 26
    TabOrder = 2
    ExplicitTop = 477
    ExplicitWidth = 853
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Top = 1
      Width = 849
      Height = 23
      ExplicitLeft = 2
      ExplicitTop = 1
      ExplicitWidth = 849
      ExplicitHeight = 23
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 117
        Height = 22
        Align = alLeft
        Caption = '[F10] - Confirma'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000040000
          00130000001E0000002000000020000000200000002100000021000000210000
          002200000022000000220000002300000021000000160000000500000012281E
          16CB37291EFF463A31FFBD8150FFBC7E4DFFB97949FFB67646FFB37141FFB06D
          3DFFAD6839FFAB6535FF42362EFF3D3026FF241A13CE00000015000000193B2C
          21FF685C54FF483C34FFE8C28BFFE7C088FFE6BD85FFE5BB81FFE4B87CFFE3B5
          79FFE2B276FFE2B273FF443931FF51433AFF34261DFF0000001E000000183E2F
          24FF6C6057FF4A3F37FFD9B27DFFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A6
          6DFFD4A56AFFD4A268FF473B33FF5B4F47FF37291EFF0000001D000000164031
          26FF6F645CFF4C4038FFFFFFFFFFF7F1EBFFF7F0EBFFF7F0EBFFF7EFEBFFF6EF
          EAFFF6EFEAFFF6EFE9FF463B34FF5D5249FF3A2C21FF0000001B000000144434
          29FF73675FFF4F443CFFFFFFFFFFF8F2EDFFF8F1EDFFF7F1EDFFF7F0EDFFF8F1
          EBFFF7F0EBFFF7F0ECFF4A4037FF5F534BFF3D2E23FF00000019000000124637
          2CFF776B63FF50453DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF4E433BFF61544CFF403126FF0000001700000010493A
          2FFF796E66FF50453DFF61564EFF60564EFF60554DFF5F544CFF5E544CFF5E53
          4BFF5D524AFF5C5249FF5B5149FF61554DFF433429FF000000150000000E4C3D
          32FF7C706AFF674E44FF654B42FF634A41FF61473FFF5F473EFF5C443CFF5B43
          3AFF594139FF584038FF573F37FF63574FFF46362DFF000000130000000D4E3F
          35FF80746DFF6B5248FFF4ECE6FFE9DACEFFE9D8CDFFE9D8CCFFE9D8CBFFE8D7
          CAFFF3EAE2FFF3E9E2FF5A4139FF645850FF483A2FFF000000110000000B5142
          36FF827770FF70564DFFF9F5F2FFF4EAE4FFF1E6DEFFEBDCD2FFE9D9CCFF4E41
          3DFF60534CFFF3EAE3FF5D453CFF655951FF4C3D32FF0000000F000000095344
          39FF857A73FF755A50FFFAF6F3FFF5EDE7FFF4EDE6FFF4ECE6FFEFE2DAFF493D
          38FF5A4D46FFF4EBE4FF60483FFF655A52FF4F3F34FF0000000D000000075545
          3AFF887D76FF795E54FFFAF6F4FFF5EEE9FFF5EDE7FFF4EDE7FFF4ECE6FF473A
          36FF483D36FFE9D9CDFF644C43FF675A52FF514137FF0000000B000000065748
          3DFF898079FF7C6157FFFAF7F4FFFAF6F4FFFAF6F4FFFAF6F3FFFAF6F3FFFAF5
          F2FFF5EEE9FFF4ECE6FF695046FF82776FFF534439FF00000009000000034235
          2EC058493DFF7F645AFF998178FF967F75FF937A72FF8E786DFF8B7269FF866E
          64FF82695FFF7D645BFF6E544AFF56453BFF3F332BC200000005000000000000
          0002000000030000000400000004000000040000000400000005000000050000
          0005000000050000000500000006000000060000000400000001}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarTodos: TBitBtnLocked
        Left = 117
        Top = 0
        Width = 143
        Height = 22
        Align = alLeft
        Caption = '[F5] - Marcar Todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000090000000E0000000F0000000F0000000F00000010000000100000
          00100000001100000011000000100000000B0000000300000000000000000000
          0008285B8FC0357DC6FF327AC4FF3077C2FF2D75C1FF2B73C0FF2870BEFF266E
          BDFF256DBCFF226BBBFF216AB9FF154B84C20000000A00000000000000000000
          000C3C82CAFF77C2EEFF64B7EAFF61B5EAFF5DB4E9FF5AB2E8FF58B0E7FF54AF
          E7FF51ACE7FF50ABE6FF4DAAE6FF216ABAFF0000000F00000000000000000000
          000C3F85CBFF80C7EFFF3F8BCBFF3C88CBFF3986C8FF3583C7FF3381C6FF307F
          C4FF2F7FC4FF2D7DC3FF50ACE7FF246CBBFF0000000F00000000000000000000
          000B4288CDFF88CBF0FF4490CEFFF3ECEAFFEDE6E4FFEFEAE7FFE6E1DEFFE9E4
          E1FFECE5E1FF3181C5FF55AFE7FF256EBDFF0000000F00000000000000000000
          000B458BD0FF91D0F1FF4A95D1FFF5F1EFFFEFECE9FFA8B7AFFF125838FF6688
          77FFE7E2DFFF4D91CDFF59B1E8FF2971BEFF0000000E00000000000000000000
          000A498ED2FF99D4F3FF65A5D8FFF5F3F2FFAEBFB5FF1E825BFF2EE1AAFF1574
          4FFFA2B0A7FF8BB5DAFF63B6E9FF2B73C0FF0000000D00000000000000000000
          00094C92D3FFADDDF5FFA3C8E6FFB6C9C0FF258863FF40ECB9FF38ECB7FF2BD1
          9CFF236749FF87ACC6FF95CCEDFF2F76C2FF0000000D00000000000000000000
          00094E95D5FFB8E1F7FF84B2BEFF34906CFF5EF2C9FF71F9D7FF77F7D7FF41EB
          B9FF23B081FF326D5FFFA7CDE3FF6499D1FF0000000C00000000000000000000
          00085397D7FFBEE4F7FF78AFB3FF4AAA89FF77DBBEFF419E7EFF237956FF6ADF
          C1FF41E9B8FF1D9A6FFF52867FFF92B4D6FF0000000D00000000000000000000
          0007559AD9FFC5E8F9FFAFD2ECFFA3C5B7FF52967BFF98B8A9FFC5D1CBFF408D
          6FFF6DE1C3FF48ECBDFF18855CFF5B8891FF0000001500000001000000000000
          0007589DDAFFBDE6F9FF84BCE4FFF8F8F8FFF0F0EEFFEEEEECFFEDEBEAFFD1D9
          D4FF3D896BFF62D0B3FF66EFCCFF1C6F4DFF0000001B00000002000000000000
          00065B9FDCFFC2E7F7FF6AA6D2FFA5A3A1FF7D7976FF645E5DFF696462FFABA8
          A8FFB2B7B3FF3B826DFF359170FF6D95A5FF0000001300000000000000000000
          00055DA1DEFFC5E6F5FF767C80FFB3AEACFFD2CDCAFFE5E0DDFFCFC6C1FFB8AF
          AAFFC1BEBDFFA6ABAFFFC3D9E6FF9BBDDEFF0000000A00000000000000000000
          00034778A6C05DA0DBFF918987FF8D8682FF88817FFFD0CCCAFFC8C3C1FF6C66
          64FF76726FFF837F7DFF5C95CBFF4E7BA6CA0000000500000000000000000000
          00010000000300000004000000050000000525232243716C6ACA605B59CA1D1B
          1B44000000060000000600000006000000040000000100000000}
        TabOrder = 1
        OnClick = btnMarTodosClick
      end
      object btnDesmarTodos: TBitBtnLocked
        Left = 260
        Top = 0
        Width = 143
        Height = 22
        Align = alLeft
        Caption = '[F6] - Desmarcar Todos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00030000000C0000001300000014000000150000001500000016000000160000
          001700000017000000170000000F000000040000000000000000000000000000
          000B1F467BC32B61AAFF2B60A9FF2A5EA9FF295EA8FF285DA7FF275CA7FF275A
          A6FF265AA5FF2558A5FF1A3E75C70000000F0000000000000000000000000000
          000F3067AEFF87CBF1FF60B9EDFF60B8ECFF5EB8ECFF5DB7EBFF5CB6ECFF5AB6
          EBFF5AB5EAFF59B4EBFF275BA7FF000000160000000000000000000000000000
          000F336BB1FF90D1F3FF337ABDFF3179BDFF3176BCFF3074BBFF3072BAFF2E70
          B9FF2D6FB8FF5CB7ECFF2A5FA9FF000000160000000000000000000000000000
          000E3770B3FF98D5F4FF367EC0FFFBF6F2FFF6EEE6FFF6EEE6FFF6EDE5FFF6ED
          E4FF2F73BAFF61BAECFF2D63ABFF000000140000000000000000000000000000
          000D3A75B6FFA1D9F5FF3882C2FFFBF8F4FFF7EFE8FFF6EFE6FFF6EEE6FFF5EE
          E5FF3278BDFF66BDEEFF3067AEFF000000130000000000000000000000000000
          000C3E7AB9FFA9DEF7FF3A87C5FFFCFAF7FFF7F0E9FFF7F0E8FFF7EFE7FFF6EF
          E7FF347CBFFF6AC1EFFF336CB1FF000000120000000000000000000000000000
          000A417FBCFFB1E2F7FF3D8CC8FFFDFBF9FFF7F2EAFFF8F1E9FFF6EFE8FFF4ED
          E5FF377FC0FF6FC4EDFF3771B3FF000000110000000000000000000000000000
          00094584BFFFB9E6F9FF3F8FCBFFFDFCFBFFF8F3ECFFF6EFE8FFF2EBE4FFF1EA
          E2FF3981BDFF74C4ECFF3B75B5FF000000100000000000000000000000000000
          0008498AC2FFBFE9FAFF4194CCFFFDFCFBFFF1EAE5FFE9E3DCFFE9E1DAFFE7DF
          D9FF3C81B8FF77C4E7FF3E7AB6FF0000000E0000000000000000000000000000
          00074C8EC6FFC5ECFBFF5BA6D3FFE8E6E4FFCBC7C0FFBDB7B2FFBBB4B0FFC5BE
          B9FF4E87AEFF7ABFDCFF427DB6FF0000000D0000000000000000000000000000
          00065093C9FFD6F3FCFF6EA4C2FFA1877DFF82594AFF754737FF7A5142FF8D72
          68FF577D96FF89B8CAFF4581BAFF0000000C0000000000000000000000000000
          00055298CCFFE0F6FDFF998178FFC0A396FFE3D3C9FFE8D5C4FFD6BEAFFFB395
          88FF755D56FFB8CCD4FF4888C0FF0000000A0000000000000000000000000000
          0003407499C082BBDEFFA88577FFA88071FFA57D6DFFF0E5DBFF8D6556FF9D73
          64FF997263FF78AED4FF396A92C3000000060000000000000000000000000000
          00010000000300000004000000050000000559453D87AA8373FF4B372F870000
          0007000000070000000700000005000000020000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 2
        OnClick = btnDesmarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 759
      Top = 2
      Width = 92
      Align = alRight
      Caption = '[ESC] - Sair'
      ExplicitLeft = 759
      ExplicitTop = 1
      ExplicitWidth = 92
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 853
    Height = 105
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label5: TLabel
      Left = 8
      Top = 8
      Width = 113
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Per'#237'odo de Cadastro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 221
      Top = 8
      Width = 6
      Height = 14
      Caption = #224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 113
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo de Vencimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 221
      Top = 32
      Width = 6
      Height = 14
      Caption = #224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 86
      Top = 57
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label20: TLabel
      Left = 76
      Top = 81
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object cxDtaCadIni: TcxDateEdit
      Tag = 99
      Left = 122
      Top = 5
      Properties.DateButtons = []
      Style.LookAndFeel.NativeStyle = True
      Style.LookAndFeel.SkinName = 'Blue'
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.SkinName = 'Blue'
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.SkinName = 'Blue'
      StyleHot.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.SkinName = 'Blue'
      TabOrder = 0
      Width = 95
    end
    object cxDtaCadFin: TcxDateEdit
      Tag = 99
      Left = 231
      Top = 5
      Properties.DateButtons = []
      Style.LookAndFeel.NativeStyle = True
      Style.LookAndFeel.SkinName = 'Blue'
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.SkinName = 'Blue'
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.SkinName = 'Blue'
      StyleHot.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.SkinName = 'Blue'
      TabOrder = 1
      Width = 95
    end
    object cxDtaVenIni: TcxDateEdit
      Tag = 99
      Left = 122
      Top = 29
      Properties.DateButtons = []
      Style.LookAndFeel.NativeStyle = True
      Style.LookAndFeel.SkinName = 'Blue'
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.SkinName = 'Blue'
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.SkinName = 'Blue'
      StyleHot.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.SkinName = 'Blue'
      TabOrder = 2
      Width = 95
    end
    object cxDtaVenFin: TcxDateEdit
      Tag = 99
      Left = 231
      Top = 29
      Properties.DateButtons = []
      Style.LookAndFeel.NativeStyle = True
      Style.LookAndFeel.SkinName = 'Blue'
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.SkinName = 'Blue'
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.SkinName = 'Blue'
      StyleHot.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.SkinName = 'Blue'
      TabOrder = 3
      Width = 95
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 122
      Top = 53
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 5
      OnExit = edtCodCliExit
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
      Left = 195
      Top = 53
      Width = 478
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNomEmp: TEditFocus
      Left = 195
      Top = 78
      Width = 478
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 122
      Top = 77
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 8
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
    object chkSomSemDesCob: TcxCheckBox
      Left = 332
      Top = 30
      Caption = 'Listar somente registros sem gera'#231#227'o de despesas de cobran'#231'a'
      State = cbsChecked
      TabOrder = 4
    end
  end
  object cxDados: TcxGrid [3]
    Left = 0
    Top = 105
    Width = 853
    Height = 372
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDadosView: TcxGridDBTableView
      OnKeyDown = cxDadosViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxDadosViewCellDblClick
      OnCustomDrawCell = cxDadosViewCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' dados para exibir>'
      OptionsView.GroupByBox = False
      object colDuplic: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'DUPLIC'
        SortIndex = 0
        SortOrder = soAscending
        Width = 151
      end
      object colClient: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENT'
        Width = 233
      end
      object colCodVen: TcxGridDBColumn
        Caption = 'Ven'
        DataBinding.FieldName = 'CTR_CODVEN'
        Width = 25
      end
      object colDtaCad: TcxGridDBColumn
        Caption = 'Dta.Cad.'
        DataBinding.FieldName = 'CTR_DTACAD'
      end
      object colDtaVen: TcxGridDBColumn
        Caption = 'Dta.Ven.'
        DataBinding.FieldName = 'CTR_DTAVEN'
      end
      object colValDup: TcxGridDBColumn
        Caption = 'Vr.Duplicata'
        DataBinding.FieldName = 'CTR_VALDUP'
        Width = 88
      end
      object colDesCob: TcxGridDBColumn
        Caption = 'Vr.Desp.Cob.Atual'
        DataBinding.FieldName = 'CTR_DESCOB'
        Width = 96
      end
      object colPreDcb: TcxGridDBColumn
        Caption = 'Vr.Prev.Desp.Cob.'
        DataBinding.FieldName = 'PREDCB'
        Width = 96
      end
      object colMarDes: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object cxDadosLevel1: TcxGridLevel
      GridView = cxDadosView
    end
  end
  inherited pnlStatus: TPanel
    Top = 503
    Width = 853
    TabOrder = 3
    ExplicitTop = 503
    ExplicitWidth = 853
    inherited pnlNomeForm: TPanel
      Left = 682
      ExplicitLeft = 682
    end
    inherited pnlInfo: TPanel
      Width = 682
      ExplicitWidth = 682
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 512
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 512
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 400
    Top = 512
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 16
    Top = 424
  end
  object qryDados: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 72
    Top = 424
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'pvdDados'
    Left = 184
    Top = 424
  end
  object pvdDados: TUniDataSetProvider
    DataSet = qryDados
    Options = []
    Left = 128
    Top = 424
  end
end
