inherited frmCadTabelaFaixasSimplesNacional: TfrmCadTabelaFaixasSimplesNacional
  Width = 922
  Height = 800
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de Tabelas de Faixas de Tributa'#231#227'o Simples Nacional'
  WindowState = wsMaximized
  ExplicitWidth = 922
  ExplicitHeight = 800
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 730
    Width = 916
    Height = 25
    ExplicitTop = 730
    ExplicitWidth = 916
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 835
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 835
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 90
        Height = 21
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 90
        Width = 90
        Height = 21
        ExplicitLeft = 90
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 180
        Width = 90
        Height = 21
        ExplicitLeft = 180
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 270
        Width = 90
        Height = 21
        ExplicitLeft = 270
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 360
        Width = 90
        Height = 21
        ExplicitLeft = 360
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 450
        Width = 90
        Height = 21
        ExplicitLeft = 450
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 837
      Height = 21
      Align = alRight
      ExplicitLeft = 837
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 755
    Width = 916
    ExplicitTop = 755
    ExplicitWidth = 916
    inherited pnlNomeForm: TPanel
      Left = 690
      Width = 226
      ExplicitLeft = 690
      ExplicitWidth = 226
    end
    inherited pnlInfo: TPanel
      Width = 690
      ExplicitWidth = 690
    end
  end
  inherited pgcDados: TPageControl
    Left = 800
    Top = 456
    Width = 89
    Height = 57
    Align = alNone
    Visible = False
    ExplicitLeft = 800
    ExplicitTop = 456
    ExplicitWidth = 89
    ExplicitHeight = 57
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 81
      ExplicitHeight = 25
    end
  end
  object grbDadosGerais: TGroupBox [3]
    Left = 0
    Top = 0
    Width = 916
    Height = 97
    Align = alTop
    Caption = '   Dados Gerais   '
    TabOrder = 4
    StyleElements = [seFont, seBorder]
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 8
      Top = 47
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblTipo: TLabel
      Left = 37
      Top = 70
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo:'
    end
    object Label4: TLabel
      Left = 220
      Top = 70
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ini. Vig'#234'ncia:'
    end
    object Label6: TLabel
      Left = 360
      Top = 70
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fim Vig'#234'ncia:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 21
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TSN_CODIGO'
      DataSource = dtsSimPau
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 64
      Top = 44
      Width = 288
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TSN_DESCRI'
      DataSource = dtsSimPau
      MaxLength = 60
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cmbTipTab: TComboBoxFocus
      Tag = 99
      Left = 64
      Top = 67
      Width = 145
      Height = 22
      DoubleBuffered = True
      Enabled = False
      ParentDoubleBuffered = False
      TabOrder = 3
      OnChange = cmbTipTabChange
      Items.Strings = (
        'Com'#233'rcio'
        'Ind'#250'stria'
        'Servi'#231'o (Anexo III)'
        'Servi'#231'o (Anexo IV)'
        'Servi'#231'o (Anexo V)'
        'Servi'#231'o (Anexo V-A)')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object mskIniVig: TMaskEditFocus
      Tag = 99
      Left = 283
      Top = 67
      Width = 69
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
      TabOrder = 4
      Text = '  /  /    '
      OnChange = mskIniVigChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object dbeALIQEF: TDBCheckBox
      Tag = 99
      Left = 372
      Top = 47
      Width = 150
      Height = 17
      Caption = 'Calcular Al'#237'quota Efetiva'
      DataField = 'TSN_ALIQEF'
      DataSource = dtsSimPau
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object mskFimVig: TMaskEditFocus
      Tag = 99
      Left = 427
      Top = 67
      Width = 69
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
      TabOrder = 5
      Text = '  /  /    '
      OnChange = mskFimVigChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object dbrdgRegime: TDBRadioGroup
      Left = 523
      Top = 44
      Width = 167
      Height = 47
      Caption = 'Regime'
      Columns = 2
      DataField = 'TSN_REGIME'
      DataSource = dtsSimPau
      Items.Strings = (
        'Regular'
        'H'#237'brido')
      TabOrder = 6
      Values.Strings = (
        'R'
        'H')
    end
  end
  object grbFaixasFaturamento: TGroupBox [4]
    Left = 0
    Top = 97
    Width = 916
    Height = 633
    Align = alClient
    Caption = '   Faixas de Faturamento / Al'#237'quota   '
    TabOrder = 3
    StyleElements = [seFont, seBorder]
    object lblRelacaoR: TLabel
      Left = 2
      Top = 603
      Width = 912
      Height = 14
      Align = alBottom
      Caption = 
        ' Obs.: (r) representa a rela'#231#227'o de gastos com sal'#225'rios (inclu'#237'do' +
        ' encargos) e a receita bruta dos '#250'ltimos 12 meses.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 626
    end
    object lblLegenda: TLabel
      Left = 2
      Top = 617
      Width = 912
      Height = 14
      Align = alBottom
      Caption = 
        ' Legenda: '#39'>'#39' (maior que), '#39'<'#39' (menor que), '#39'>='#39' (maior ou igual' +
        ' que), '#39'<='#39' (menor ou igual que).'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 508
    end
    object grdFaixas: TcxGridCitel
      Left = 2
      Top = 151
      Width = 912
      Height = 452
      Align = alClient
      BorderStyle = cxcbsNone
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdFaixasTableView1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = grdFaixasTableView1CellDblClick
        DataController.DataSource = dtsFaixas
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.KeyFieldNames = 'AUTOINCREM'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Nenhuma mensagem para ser exibida'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdFaixasTSN_IDXFXA: TcxGridDBColumn
          Caption = 'Nro'
          DataBinding.FieldName = 'TSN_IDXFXA'
          SortIndex = 0
          SortOrder = soAscending
          Width = 40
        end
        object grdFaixasTSN_LIMINF: TcxGridDBColumn
          Caption = 'Lim. Inferior (R$)'
          DataBinding.FieldName = 'TSN_LIMINF'
          Width = 110
        end
        object grdFaixasTSN_LIMSUP: TcxGridDBColumn
          Caption = 'Lim. Superior (R$)'
          DataBinding.FieldName = 'TSN_LIMSUP'
          Width = 110
        end
        object grdFaixasTSN_ALIQUO: TcxGridDBColumn
          Caption = '% Al'#237'quota'
          DataBinding.FieldName = 'TSN_ALIQUO'
          Width = 60
        end
        object grdFaixasTSN_ALIRPJ: TcxGridDBColumn
          Caption = '% IRPJ'
          DataBinding.FieldName = 'TSN_ALIRPJ'
          Width = 55
        end
        object grdFaixasTSN_ALCSLL: TcxGridDBColumn
          Caption = '% CSLL'
          DataBinding.FieldName = 'TSN_ALCSLL'
          Width = 55
        end
        object grdFaixasTSN_ALQCOF: TcxGridDBColumn
          Caption = '% COFINS'
          DataBinding.FieldName = 'TSN_ALQCOF'
          Width = 60
        end
        object grdFaixasTSN_ALQPIS: TcxGridDBColumn
          Caption = '% PIS'
          DataBinding.FieldName = 'TSN_ALQPIS'
          Width = 55
        end
        object grdFaixasTSN_ALQCPP: TcxGridDBColumn
          Caption = '% CPP'
          DataBinding.FieldName = 'TSN_ALQCPP'
          Width = 55
        end
        object grdFaixasTSN_ALQICM: TcxGridDBColumn
          Caption = '% ICMS'
          DataBinding.FieldName = 'TSN_ALQICM'
          Width = 55
        end
        object grdFaixasTSN_ALQISS: TcxGridDBColumn
          Caption = '% ISS'
          DataBinding.FieldName = 'TSN_ALQISS'
          Width = 55
        end
        object grdFaixasTSN_ALQIPI: TcxGridDBColumn
          Caption = '% IPI'
          DataBinding.FieldName = 'TSN_ALQIPI'
          Width = 55
        end
        object grdFaixasTSN_ALQCBS: TcxGridDBColumn
          Caption = '% CBS'
          DataBinding.FieldName = 'TSN_ALQCBS'
          Width = 55
        end
        object grdFaixasTSN_ALQIBS: TcxGridDBColumn
          Caption = '% IBS'
          DataBinding.FieldName = 'TSN_ALQIBS'
          Width = 55
        end
        object grdFaixasTSN_VLRDES: TcxGridDBColumn
          Caption = 'Vr. '#224' Descontar'
          DataBinding.FieldName = 'TSN_VLRDES'
          Width = 85
        end
      end
      object grdFaixasLevel1: TcxGridLevel
        GridView = grdFaixasTableView1
      end
    end
    object pnlDadosFaixas: TPanel
      Left = 2
      Top = 16
      Width = 912
      Height = 135
      Align = alTop
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 1
      object lblLimInf: TLabel
        Left = 18
        Top = 7
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lim. Inferior:'
      end
      object lblLimSup: TLabel
        Left = 11
        Top = 31
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lim. Superior:'
      end
      object lblAliquo: TLabel
        Left = 12
        Top = 55
        Width = 108
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'q. Simples Nacional:'
      end
      object lblIrpj: TLabel
        Left = 265
        Top = 7
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota IRPJ:'
      end
      object lblCsll: TLabel
        Left = 259
        Top = 31
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota CSLL:'
      end
      object lblCofins: TLabel
        Left = 248
        Top = 55
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota COFINS:'
      end
      object lblPis: TLabel
        Left = 458
        Top = 7
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota PIS:'
      end
      object lblCpp: TLabel
        Left = 454
        Top = 31
        Width = 64
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota CPP:'
      end
      object lblIcms: TLabel
        Left = 449
        Top = 55
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota ICMS:'
      end
      object btnCalcLimInf: TSpeedButton
        Left = 202
        Top = 4
        Width = 22
        Height = 22
        Hint = 'Calcular limite inferior'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000100000005040F0B2F104531A51A68
          49EB1B7350FF196849EB104530A6030F0A310000000600000001000000000000
          000000000000000000000000000000000005082117531D7352F5299F75FF31BD
          8DFF54D9B0FF2EBD8BFF279D73FF1B7050F50820175600000006000000000000
          000000000000000000000000000204100C2C237958F536BF90FF3FD2A2FF5ADC
          B4FF135C3BFF57DBB1FF3AD09DFF30BC8CFF217655F5040F0B2F000000000000
          0000000000000000000000000004164C389F3AAE86FF41D5A5FF3AC597FF1560
          3FFF15603FFF155F3EFF40C599FF38D09DFF31A980FF154A35A1000000000000
          000000000001000000030000000925785AE746CEA3FF47D8AAFF45D6A8FF53DB
          B0FF63DFB9FF176442FF2FA67CFF3DD2A1FF3BC898FF227355E7000000000000
          0003060C16281D39669F1B3560972D8968FD55DBB3FF4DDAAEFF4FDBAFFF44AA
          87FF196B47FF2C966EFF45D7A8FF43D6A6FF48D6A8FF298262FA000000020E1B
          304C3462A7F45091CDFF5B859EB0368F71F66BDBBAFF52DDB3FF4ACFA4FF1C70
          4DFF68DCB9FF6CE3C1FF52DBB1FF49D8AAFF60D7B2FF287C5EE7070E1726396A
          ADF46AB5E3FF8BCEF0FF315387C5236365D863C0A3FF66E3BFFF55DFB6FF1E75
          51FF1E7550FF1E7550FF42C097FF5DDFB9FF5CBC9EFF1C533F9A25426D9A67A6
          D9FF80D0F2FF5E8DC5FF315F9DE040788DAE399677FA7FDAC1FF7CE9CCFF64E3
          BFFF207954FF62E2BDFF77E7C8FF79D8BDFF338D6DF106110D253D6AABE586CD
          EFFFBBEAFAFF2E58A8FF98CAE9FF8AB3C5CB42838BBB3A9A79FB64C1A4FF86DF
          C7FF97EFD9FF84DFC6FF62C0A2FF379272F40F29204B000000024779BEF99CE0
          F7FF1B48A3FF1A47A2FF1A46A2FF18439AF661A1BFCB478093AD3E8D83D93B97
          7BF43A9C79FF348A6BE3235D489D07120E2200000002000000004573B4E5A9DE
          F4FF9BE1F9FF3060B3FF96CCECFF8DD7F5FFA3DEF7FF78B9D5E05B9BB9C55B88
          A2B028456D9200000004000000020000000100000000000000002F4D77958EBB
          E4FFADEAFAFF5F9AD4FF5286C9FFB0DDF4FF4E82C6FF6BB1E2FF8BD4F3FF7BAF
          DFFF2C4A729600000002000000000000000000000000000000000A1019205184
          C5F0B2DBF2FFB7E9F9FF528ACEFF255AB7FF4D85CBFFA3DDF6FF9FD0EEFF4D7E
          C0F1090F18220000000000000000000000000000000000000000000000011826
          39475488CAF38EBCE6FFB7DFF4FFCAF1FCFFB0DCF4FF87B7E3FF5284C6F31725
          3848000000010000000000000000000000000000000000000000000000000000
          00010B11192035557E974F7FBCE15990D5FF4F7EBBE23556809B0A1119200000
          0001000000000000000000000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnCalcLimInfClick
      end
      object lblIss: TLabel
        Left = 643
        Top = 7
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota ISS:'
      end
      object lblIpi: TLabel
        Left = 649
        Top = 31
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota IPI:'
      end
      object lblVlrDescontar: TLabel
        Left = 596
        Top = 55
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr '#224' descontar:'
      end
      object Label3: TLabel
        Left = 57
        Top = 79
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota CBS:'
      end
      object Label5: TLabel
        Left = 269
        Top = 79
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Al'#237'quota IBS:'
      end
      object edtLimInf: TCurrencyEditFocus
        Left = 80
        Top = 4
        EditValue = 0c
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
      object edtLimSup: TCurrencyEditFocus
        Left = 80
        Top = 28
        EditValue = 0c
        StyleFocused.Color = clInfoBk
        TabOrder = 1
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 121
      end
      object edtAliquo: TCurrencyEditFocus
        Left = 126
        Top = 52
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 2
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 75
      end
      object edtIrpj: TCurrencyEditFocus
        Left = 333
        Top = 3
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 3
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
      object edtCsll: TCurrencyEditFocus
        Left = 333
        Top = 28
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 4
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
      object edtCofins: TCurrencyEditFocus
        Left = 333
        Top = 52
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 5
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
      object edtPis: TCurrencyEditFocus
        Left = 521
        Top = 4
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 6
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
      object edtCpp: TCurrencyEditFocus
        Left = 521
        Top = 28
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 7
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
      object edtIcms: TCurrencyEditFocus
        Left = 521
        Top = 52
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 8
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
      object edtIss: TCurrencyEditFocus
        Left = 707
        Top = 4
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 9
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
      object edtIpi: TCurrencyEditFocus
        Left = 707
        Top = 28
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 10
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
      object pnlBotoesFaixas: TPanel
        Left = 0
        Top = 101
        Width = 908
        Height = 30
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 12
        object btnAdicionar: TBitBtnLocked
          Left = 10
          Top = 4
          Width = 90
          Height = 22
          Caption = 'Adicio&nar'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000100000003000000080000000C0000
            000E0000000D0000000800000003000000010000000000000000000000020000
            000A00000010000000110000001300000018050E0A3F16412DAC216043EC256A
            48FF216141ED163F2BAC050E09390000000900000001000000000000000A7B50
            43C2AB705CFFAB6F5AFFC29A8CFFA2A191FF307554FF2D9D71FF24BA82FF23CB
            8EFF23BA82FF25986BFF2C7050FD0A1E145C00000006000000000000000EAD73
            5FFFFDFBF9FFFAF4F2FFDCE4DEFF388260FF40C397FF28CD92FF40956DFF487E
            5DFF3F946CFF26CD91FF27BA84FF297150F5050F0A2F000000030000000EB077
            62FFFDFBFAFFF6EFEBFF80AD96FF54B593FF36D29CFF2ECE95FF4A8362FFFFFF
            FFFF4A8161FF2CD096FF2CCF95FF31A87AFF1B4833A1000000060000000CB079
            66FFFDFBFBFFF7F2EFFF499371FF6CDBBBFF469D76FF4D8865FF4D8765FFF6F1
            EBFF4D8665FF4D8664FF459B73FF33C892FF2B7453E7000000080000000BB37C
            69FFFEFCFBFFF8F4F1FF3C926DFF81E9CCFF508C6AFFEADBD3FFF8F3EFFFF9F3
            EFFFF8F3EFFFFFFFFFFF4E8968FF3FD5A3FF348662FA000000080000000AB67F
            6CFFFEFDFCFFF8F3F1FF4FA07DFFB1E9D8FF6CA98CFF528F6EFF528F6DFFFAF5
            F3FF528F6CFF518E6BFF5EA583FF76DCBBFF338260E70000000700000009B983
            71FFFEFDFCFFFAF5F2FF8CC2AAFF94CBB5FFE2FAF5FFC5F5E9FF539371FFECDE
            D8FF539270FFABF0DDFFB0F1DEFF84C6ADFF2358419A0000000400000007BC88
            77FFFEFEFDFFFBF4F0FFE4ECE6FF4EAA84FFC8E7DBFFEEFDFAFF7AB095FF5696
            74FF74AF94FFD9F9F2FFBEE5D8FF3E9873F208130E250000000100000006BF8C
            7AFFFEFEFDFFFBF6F1FFFBF6F4FFC9E2D5FF4FAD85FF93CEB7FFD2ECE3FFF3FC
            FBFFD2ECE3FF92CDB6FF4DA881FF122D2251000000020000000000000005C18F
            7FFFFEFEFEFFFAF6F3FFFAF5F3FFFAF7F4FFE5EEE7FF90CAB1FF5BB48FFF46AB
            82FF5BB48EFF8EC9B1FFC9BDB1FF00000008000000000000000000000004C493
            82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFBF6F3FFFCF8F6FFFCF7F6FFFCF9
            F7FFFBF8F5FFFCFBFAFFC49587FF00000005000000000000000000000003C799
            85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
            F3FFFCF6F2FFFDFCFAFFC28F7FFF00000004000000000000000000000002C99A
            89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
            FDFFFEFDFDFFFEFDFDFFC49382FF000000030000000000000000000000019774
            67BECA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
            87FFC79887FFC89886FF927063BF000000020000000000000000}
          TabOrder = 0
          OnClick = btnAdicionarClick
        end
        object btnEditar: TBitBtnLocked
          Left = 190
          Top = 4
          Width = 90
          Height = 22
          Caption = 'E&ditar'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            00000000000000000000000000000000001F421C11FF30140DEC190A06B30304
            075F0000001B0000000500000000000000000000000000000000000000000000
            00000000000000000000000000000000001E663C2BE7B9C7D2FF7889A2FF2441
            82FF051033AF0000002100000005000000000000000000000000000000000000
            0002000000090000000E0000000F0000002041261BAE879AB2FFC8E3F5FF1F66
            B6FF2B6BA8FF051236AD0000001F000000040000000000000000000000000000
            00088C6657C0C38C7AFFC38C79FFCBA395FFA89894FF488BC3FFDEFEFDFF51B4
            E3FF1F68B7FF3173AEFF061538AA0000001C0000000400000000000000000000
            000CC5917EFFFDFBFAFFFCF8F6FFFAF7F5FFECEAE9FF7CA3BFFF479FD2FFDEFE
            FDFF59BFE9FF216BB9FF367BB3FF07173AA70000001A00000004000000000000
            000CC79481FFFEFBFAFFF9F0EAFFF8F0EAFFF7F0EBFFE8E4E1FF7EA4BFFF4BA5
            D5FFDEFEFDFF61CAEFFF246FBCFF3B83B9FF081A3DA300000018000000000000
            000BC99786FFFEFCFBFFF9F2EDFFF9F2EDFFF9F0EBFFF8F2EDFFEBE7E5FF82A7
            C2FF4EAAD7FFDEFEFDFF68D4F4FF2875BEFF3F8BBEFF091B3F9E000000000000
            000ACB9C8BFFFEFDFCFFFAF3EFFFFAF4EEFFFAF3EEFFFAF1ECFFF8F2EEFFEDE9
            E7FF85ABC7FF51AEDAFFDEFEFDFF6EDDF8FF2C7BC2FF18448BFF000000000000
            0009CFA08DFFFEFEFDFFFBF5F1FFFBF5F0FFFBF4F0FFFAF3EFFFFAF3EFFFF8F4
            EFFFEFECE9FF89AECAFF54B1DCFFDEFEFDFF4FA6D4FF102C4E93000000000000
            0009D0A393FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
            EFFFFAF6F1FFF3EFEDFF83A0B8FF357FBCFF173A598F0000000C000000000000
            0008D3A897FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
            F1FFFBF5F0FFFAF6F3FFE2CCC4FF000000160000000600000001000000000000
            0007D3AB9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
            F3FFFCF6F2FFFBF6F1FFD1A494FF0000000C0000000000000000000000000000
            0006D8AE9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7
            F5FFFBF7F4FFFCF7F3FFD3A897FF0000000B0000000000000000000000000000
            0006D8B0A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8
            F6FFFBF7F6FFFCF7F5FFD4AC9BFF0000000A0000000000000000000000000000
            0005D9B3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFE
            FEFFFEFEFEFFFEFEFEFFD7AE9EFF000000090000000000000000000000000000
            0003A3867AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3
            A2FFD9B2A2FFD8B2A2FFA08377C2000000060000000000000000}
          TabOrder = 2
          OnClick = btnEditarClick
        end
        object btnRemover: TBitBtnLocked
          Left = 280
          Top = 4
          Width = 90
          Height = 22
          Caption = '&Remover'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000001000000030000
            0007000000060000000300000006000000080000000400000001000000000000
            00000000000000000000000000000000000000000000000000030B082C4D2619
            99EA110A58A2010003160F0855A3160C7EEA0603244F00000004000000000000
            0001000000060000000A0000000B0000000B0000000B000000112E23A2EA6F85
            EAFF4150CBFF1F1689E63B48C9FF5C74E4FF180E82E700000007000000000000
            000680574CBDB37B69FFB37A68FFB37A68FFB27968FFDCC6BEFF756BC0FF7780
            DDFF6D8BEFFF5872E5FF6381EDFF6972D8FF1A13659F00000005000000000000
            0008B57D6BFFFBF7F3FFFBF6F3FFFBF6F3FFFBF5F2FFFAF5F3FFEFECEFFF4D46
            BDFF6A85EBFF7494F2FF6079E7FF262094E40101041300000002000000000000
            0008B67F6DFFFCF8F5FFF8EFECFFF7EEEAFFF7EEEAFFF9F5F3FF807DD4FF6B7E
            E2FF93B0F6FFA0B3F2FF8AA6F4FF5D6EDBFF1C186AA000000004000000000000
            0008B8826FFFFCF9F6FFF8F0ECFFF8F0ECFFF7EFECFFFAF8F7FF6261D8FFB1C3
            F6FF8D99EAFF5F5DD2FF8995E7FFA6B8F3FF3B35AEE300000004000000000000
            0007BA8473FFFDF9F8FFF8F1EEFFF8F0EDFFF8F0ECFFFAF5F3FFCECDEEFF6564
            DEFF9291E2FFF2F1F3FF8982D3FF4340BCE71212334600000002000000000000
            0007BB8776FFFDFBF9FFF9F1EFFFF9F2EEFFF8F1EEFFF8F0EDFFFAF5F3FFFAF8
            F7FFFAF7F6FFFCF9F8FFE3CFC9FF0000000C0000000200000000000000000000
            0006BD8A78FFFDFBFAFFF9F2F0FFF9F2F0FFF8F2EFFFF9F1EFFFF8F1EEFFF9F1
            EEFFF8F0EDFFFDFAF8FFBB8675FF000000080000000000000000000000000000
            0006BF8D7BFFFEFCFBFFFAF4F1FFFAF4F1FFFAF2F1FFFAF2F0FFF9F2EFFFF9F2
            EEFFF8F1EEFFFDFBF9FFBD8978FF000000080000000000000000000000000000
            0005C39381FFFEFDFDFFFBF6F4FFFBF5F4FFFBF4F2FFFAF4F2FFFAF4F1FFF9F3
            F1FFFAF3F1FFFEFCFBFFC18F7EFF000000070000000000000000000000000000
            0004C69887FFFFFEFEFFFBF7F6FFFCF6F6FFFBF6F5FFFBF6F4FFFBF5F4FFFAF5
            F3FFFAF5F3FFFEFDFDFFC59684FF000000060000000000000000000000000000
            0003C99B8AFFFFFEFEFFFBF7F6FFFCF7F6FFFCF6F5FFFBF6F5FFFCF6F5FFFBF5
            F5FFFBF6F4FFFFFEFEFFC79887FF000000050000000000000000000000000000
            0003CA9E8DFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFEFEFFFFFEFEFFFFFE
            FEFFFFFEFEFFFFFEFEFFC99B8AFF000000040000000000000000000000000000
            00029B7F74BFD0AB9CFFD0AB9CFFD0AA9CFFCFA99BFFCFA99AFFCFA999FFCFA8
            99FFCEA899FFCFA898FF997B71C0000000030000000000000000}
          TabOrder = 3
          OnClick = btnRemoverClick
        end
        object btnConfirmar: TBitBtnLocked
          Left = 100
          Top = 4
          Width = 90
          Height = 22
          Caption = 'Confir&mar'
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
          TabOrder = 1
          OnClick = btnConfirmarClick
        end
        object btnCancelar: TBitBtnLocked
          Left = 371
          Top = 4
          Width = 90
          Height = 22
          Caption = 'Cancela&r'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000020000000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C
            76E4120852AD06031B4D0000000E000000030000000000000000000000000000
            000301010519130A55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430
            C3FF2225AFFF211594FF140B58B20101051E0000000400000000000000020101
            03151C1270CD2522A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344
            D0FF394AD4FF2D3CCDFF2523A8FF1C1270D20101051D00000003000000091912
            5BA72A27AAFF2F41D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137
            BCFF2726ABFF3540C7FF2E40D0FF2927ACFF1A115EB10000000D08061C3D3129
            A2FD2C3CCCFF3842C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89
            CEFFEDEDF8FF5F5DBDFF3741C6FF2B3ACDFF3028A4FF0907204A1E185F9F373B
            BCFF3042D0FF2621A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
            EDFFF3E9E2FFECE6EBFF2621A5FF2E3FCFFF343ABEFF201A66B0312A92E03542
            CBFF3446D1FF2C2FB5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
            E2FFEADAD1FF7F6FACFF2B2EB5FF3144D0FF3040CBFF312A95E53E37AEFA3648
            D0FF374AD3FF3A4ED5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
            E5FF897DB8FF3233B4FF384BD3FF3547D2FF3446D1FF3E37AEFA453FB4FA4557
            D7FF3B50D5FF4C5FDAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
            E8FF9087C5FF4242B7FF495DD8FF394CD4FF3F52D4FF443FB3FA403DA1DC5967
            DAFF5B6EDDFF4F4DBAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
            EAFFFAF5F2FF8F89CAFF4E4DB9FF576ADCFF5765D9FF403EA4E12E2D70987C85
            DDFF8798E8FF291D9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
            D8FFF4ECE7FFE5D9DCFF291D9BFF8494E7FF7A81DDFF33317BAC111125356768
            D0FC9EACEDFF686FCEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68
            A8FFCBB5BCFF5646A1FF666DCCFF9BAAEEFF696CD0FD1212273F000000043B3B
            79977D84DFFFA5B6F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252
            BBFF2D219BFF6B72D0FFA2B3F0FF8086E0FF404183A700000008000000010303
            050C4E509DBC8087E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BAD
            EFFFA2B3F0FFACBCF3FF838AE3FF4F52A0C10303051100000002000000000000
            000100000005323464797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AE
            EFFF939DE9FF7479DAF83234647D000000080000000200000000000000000000
            000000000000000000031213232D40437D935D61B5D07378DFFC7378DFFC5D61
            B5D040437D951212223000000004000000010000000000000000}
          TabOrder = 4
          OnClick = btnCancelarClick
        end
      end
      object edtVlrDes: TCurrencyEditFocus
        Left = 673
        Top = 52
        EditValue = 0c
        StyleFocused.Color = clInfoBk
        TabOrder = 11
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 99
      end
      object edtCBS: TCurrencyEditFocus
        Left = 126
        Top = 76
        EditValue = 0.000000000000000000
        Properties.AssignedValues.EditFormat = True
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 13
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 75
      end
      object edtIBS: TCurrencyEditFocus
        Left = 333
        Top = 76
        EditValue = 0c
        Properties.DisplayFormat = '%, 0.00;-%, 0.00'
        StyleFocused.Color = clInfoBk
        TabOrder = 14
        OnExit = edtLimInfExit
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 65
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 712
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 712
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 712
    Top = 112
  end
  object dtsSimPau: TDataSource
    Left = 536
    Top = 160
  end
  object dtsFaixas: TDataSource
    DataSet = cdsFaixas
    Left = 192
    Top = 329
  end
  object cdsFaixas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 376
  end
end
