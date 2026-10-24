inherited frmCadPrmRotCitelAbastece: TfrmCadPrmRotCitelAbastece
  Width = 1177
  Height = 423
  Caption = 'Par'#226'metros da rotina Citel Abastece'
  ExplicitWidth = 1177
  ExplicitHeight = 423
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 352
    Width = 1171
    ExplicitTop = 352
    ExplicitWidth = 1171
    inherited FlwBotoes: TFlowPanel
      Width = 1167
      ExplicitWidth = 1167
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1088
      ExplicitLeft = 1088
    end
  end
  inherited pnlStatus: TPanel
    Top = 378
    Width = 1171
    ExplicitTop = 378
    ExplicitWidth = 1171
    inherited pnlNomeForm: TPanel
      Left = 1000
      ExplicitLeft = 1000
    end
    inherited pnlInfo: TPanel
      Width = 1000
      ExplicitWidth = 1000
    end
  end
  object grpParametros: TcxGroupBox [2]
    AlignWithMargins = True
    Left = 703
    Top = 3
    Align = alClient
    Caption = 'Par'#226'metros para abastecimento autom'#225'tico'
    TabOrder = 2
    Height = 346
    Width = 465
    object grpEstSegCD: TDBRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 44
      Width = 455
      Height = 94
      Margins.Top = 0
      Align = alTop
      Caption = 'Estoque de seguran'#231'a do CD'
      DataField = 'PRM_ESTSEG'
      DataSource = dtsParametros
      Items.Strings = (
        
          'Percentual do saldo que ficar'#225' obrigat'#243'riamente dispon'#237'vel no CD' +
          '.:'
        'Dias de estoque que ficar'#225' obrigatoriamente dispon'#237'vel no CD.:'
        'Manter o estoque m'#237'nimo como seguran'#231'a do CD'
        'Sem estoque de seguran'#231'a')
      TabOrder = 0
      Values.Strings = (
        'P'
        'D'
        'M'
        'S')
    end
    object dbDiaSeg: TDBEditFocus
      Tag = 99
      Left = 354
      Top = 79
      Width = 61
      Height = 22
      DataField = 'PRM_DIASEG'
      DataSource = dtsParametros
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbPctSeg: TDBEditFocus
      Tag = 99
      Left = 354
      Top = 56
      Width = 61
      Height = 22
      DataField = 'PRM_PCTSEG'
      DataSource = dtsParametros
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object chkCnsPdc: TDBCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 199
      Width = 455
      Height = 17
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 
        'Considerar pedido de compra pendente no saldo da empresa de dest' +
        'ino?'
      DataField = 'PRM_CNSPDC'
      DataSource = dtsParametros
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object pnlQtdIte: TPanel
      Left = 2
      Top = 273
      Width = 461
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      object lblQtdIte: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 5
        Width = 190
        Height = 20
        Margins.Top = 5
        Align = alLeft
        Caption = 'Quantidade de itens por pedido gerado:'
        ExplicitHeight = 14
      end
      object dbQtdIte: TDBEditFocus
        Tag = 99
        AlignWithMargins = True
        Left = 199
        Top = 2
        Width = 61
        Height = 21
        Margins.Top = 2
        Margins.Bottom = 2
        Align = alLeft
        DataField = 'PRM_QTDITE'
        DataSource = dtsParametros
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
        ExplicitHeight = 22
      end
    end
    object pnlGerTip: TPanel
      Left = 2
      Top = 248
      Width = 461
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 5
      object lblGerTip: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 5
        Width = 91
        Height = 20
        Margins.Top = 5
        Align = alLeft
        Caption = 'Gerar pedidos por:'
        ExplicitHeight = 14
      end
      object cmbGerTIp: TDBComboBox
        Tag = 99
        AlignWithMargins = True
        Left = 100
        Top = 2
        Width = 160
        Height = 22
        Margins.Top = 2
        Margins.Bottom = 2
        Style = csDropDownList
        Align = alLeft
        DataField = 'PRM_GERTIP'
        DataSource = dtsParametros
        Items.Strings = (
          'DEPARTAMENTO'
          'FORNECEDOR'
          'GERAL'
          'GRUPO'
          'GRUPO DE PRODUTO'
          'LINHA'
          'MARCA')
        Sorted = True
        TabOrder = 0
      end
    end
    object grpTipSal: TDBRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 144
      Width = 455
      Height = 35
      Align = alTop
      Caption = 'Tipo de saldo dispon'#237'vel'
      Columns = 6
      DataField = 'PRM_TIPSAL'
      DataSource = dtsParametros
      Items.Strings = (
        'F'#237'sico'
        'Dispon'#237'vel')
      TabOrder = 3
      Values.Strings = (
        'F'
        'D')
    end
    object btnHelpTipoSaldo: TBitBtnLocked
      Left = 168
      Top = 154
      Width = 24
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000800000010000000100000
        0008000000010000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
        0B60000000070000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
        27EA0000000E0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
        30EC0000000D0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
        1A51000000050000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000600000011000000140000
        000A000000020000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000670503AA999532EFF4528
        187A000000070000000100000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
        4AF724150D490000000800000002000000000000000000000000000000000000
        0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
        9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
        000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
        AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
        00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
        76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
        000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
        70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
        000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
        C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
        0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
        77E570533B9A17100A2500000002000000000000000000000000000000000000
        0000000000000000000000000000000000010000000100000002000000030000
        0002000000020000000100000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      TabStop = False
      OnClick = btnHelpTipoSaldoClick
    end
    object pnlEmp: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 19
      Width = 455
      Height = 25
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 8
      object lblCodEmp: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 5
        Width = 106
        Height = 20
        Margins.Top = 5
        Align = alLeft
        Caption = 'Empresa selecionada:'
        ExplicitHeight = 14
      end
      object dbCodEmp: TDBEditFocus
        Tag = 99
        AlignWithMargins = True
        Left = 115
        Top = 2
        Width = 61
        Height = 21
        Margins.Top = 2
        Margins.Bottom = 2
        Align = alLeft
        DataField = 'EMP_CODEMP'
        DataSource = dtsParametros
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
        ExplicitHeight = 22
      end
    end
    object chkCnsPed: TDBCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 182
      Width = 455
      Height = 17
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 
        'Considerar pedidos de transfer'#234'ncia no saldo da empresa de desti' +
        'no?'
      DataField = 'PRM_CNSPED'
      DataSource = dtsParametros
      TabOrder = 9
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkPontoExposicao: TcxDBCheckBox
      Left = 2
      Top = 298
      Align = alTop
      Caption = 
        'Utilizar ponto de exposi'#231#227'o no c'#225'lculo da sugest'#227'o de abastecime' +
        'nto'
      DataBinding.DataField = 'PRM_PTOEXP'
      DataBinding.DataSource = dtsParametros
      Properties.ValueChecked = 'S'
      Properties.ValueUnchecked = 'N'
      TabOrder = 10
    end
    object chkDisigu: TDBCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 216
      Width = 455
      Height = 32
      Hint = 
        'Ao marcar essa op'#231#227'o, se o c.d. n'#227'o tiver quantidade suficiente ' +
        'para abastecer as lojas, ent'#227'o cada loja dever'#225' receber uma quan' +
        'tidade menor do que sua necessidade, de forma que todas as lojas' +
        ' recebam um pouco do item.'
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alTop
      Caption = 
        'Se quantidade disponivel para distribui'#231#227'o for insuficiente para' +
        ' abastecer todas as lojas, redistribuir as quantidades de forma ' +
        'que consiga atender um pouco cada loja.'
      DataField = 'PRM_DISIGU'
      DataSource = dtsParametros
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      WordWrap = True
    end
  end
  object cxGrid: TcxGridCitel [3]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 694
    Height = 346
    Align = alLeft
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDBTableView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditing = cxGridDBTableViewEditing
      OnFocusedRecordChanged = cxGridDBTableViewFocusedRecordChanged
      DataController.DataSource = dtsParametros
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridDBTableViewCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'EMP_CODEMP'
        HeaderAlignmentHorz = taCenter
        Width = 48
      end
      object cxGridDBTableViewABASTE: TcxGridDBColumn
        Caption = 'Abastecedora?'
        DataBinding.FieldName = 'PRM_ABASTE'
        RepositoryItem = cmbSimNao
        HeaderAlignmentHorz = taCenter
        Width = 81
      end
      object cxGridDBTableViewEMPABA: TcxGridDBColumn
        Caption = 'Empresa abastecedora'
        DataBinding.FieldName = 'PRM_EMPABA'
        RepositoryItem = cmbEmpAba
        HeaderAlignmentHorz = taCenter
        Width = 123
      end
      object cxGridDBTableViewABAMIN: TcxGridDBColumn
        Caption = 'Abastecer pelo m'#237'nimo ou pelo m'#225'ximo?'
        DataBinding.FieldName = 'PRM_ABAMIN'
        RepositoryItem = cmbTpEst
        HeaderAlignmentHorz = taCenter
        Width = 202
      end
      object cxGridDBTableViewCNITES: TcxGridDBColumn
        Caption = 'Considerar itens com saldo'
        DataBinding.FieldName = 'PRM_CNITES'
        RepositoryItem = cmbTpEstSal
        HeaderAlignmentHorz = taCenter
        Width = 234
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object dtsParametros: TDataSource
    Left = 336
    Top = 232
  end
  object cxEditRepository: TcxEditRepository
    Left = 88
    Top = 240
    PixelsPerInch = 96
    object cmbTpEst: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
    object cmbSimNao: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
      Properties.OnEditValueChanged = cmbSimNaoPropertiesEditValueChanged
    end
    object cmbEmpAba: TcxEditRepositoryComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.Sorted = True
    end
    object cmbTpEstSal: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownWidth = 186
      Properties.KeyFieldNames = 'VALCAM'
      Properties.ListColumns = <
        item
          FieldName = 'DESCAM'
        end>
      Properties.ListOptions.CaseInsensitive = True
      Properties.ListOptions.ShowHeader = False
    end
  end
end
