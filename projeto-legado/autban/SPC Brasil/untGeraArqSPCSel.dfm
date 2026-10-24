inherited frmGeraArqSPCSel: TfrmGeraArqSPCSel
  Width = 1266
  Height = 561
  BorderStyle = bsNone
  Caption = 'frmGeraArqSPCSel'
  Position = poMainFormCenter
  ExplicitWidth = 1266
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1266
    Height = 26
    ExplicitTop = 519
    ExplicitWidth = 1266
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 1185
      Height = 22
      ExplicitWidth = 1185
      ExplicitHeight = 22
      object btnSelTodos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F7 ] Marcar Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnSelTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 140
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F8 ]Desmarcar Todos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnDesmarcaTodosClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 280
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F10 ] Confirma'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1187
      Top = 2
      Align = alRight
      ExplicitLeft = 1187
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1266
    ExplicitTop = 545
    ExplicitWidth = 1266
    inherited pnlNomeForm: TPanel
      Left = 1095
      ExplicitLeft = 1095
    end
    inherited pnlInfo: TPanel
      Width = 1095
      ExplicitWidth = 1095
    end
  end
  object pnlTopo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1266
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Sele'#231#227'o de registros para o SPC - Brasil'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
  end
  object pnlTotais: TPanel [4]
    Left = 0
    Top = 458
    Width = 1266
    Height = 61
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label21: TLabel
      Left = 19
      Top = 14
      Width = 96
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total duplicatas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 12
      Top = 35
      Width = 103
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total Selecionado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtTotalDup: TEditFocus
      Left = 125
      Top = 13
      Width = 121
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object edtTotalSelecionado: TEditFocus
      Left = 125
      Top = 33
      Width = 121
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      EditFormat = '#,##0.00'
    end
    object gpbLegenda: TGroupBox
      Left = 262
      Top = 16
      Width = 254
      Height = 35
      Caption = 'Legenda'
      TabOrder = 2
      object shp1: TShape
        Left = 8
        Top = 15
        Width = 14
        Height = 14
      end
      object lbl1: TLabel
        Left = 27
        Top = 15
        Width = 65
        Height = 14
        Caption = 'Selecionadas'
      end
      object lbl3: TLabel
        Left = 11
        Top = 15
        Width = 8
        Height = 14
        Caption = 'A'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Shape1: TShape
        Left = 127
        Top = 15
        Width = 14
        Height = 14
      end
      object Label6: TLabel
        Left = 146
        Top = 15
        Width = 98
        Height = 14
        Caption = 'Duplicatas Baixadas'
      end
      object Label8: TLabel
        Left = 130
        Top = 15
        Width = 8
        Height = 14
        Caption = 'A'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
    end
  end
  object pnlDadosDup: TPanel [5]
    Left = 886
    Top = 22
    Width = 380
    Height = 436
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    object lblCliente: TLabel
      Left = 25
      Top = 22
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Nome: TLabel
      Left = 30
      Top = 42
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 16
      Top = 64
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 30
      Top = 84
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 107
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nosso Nro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 17
      Top = 128
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblProtesta: TLabel
      Left = 17
      Top = 171
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Protesta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 193
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc Antigo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodCliBai: TEdit
      Left = 64
      Top = 20
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 0
    end
    object edtNomCliBai: TEdit
      Left = 64
      Top = 41
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 1
    end
    object edtCodPorBai: TEdit
      Left = 64
      Top = 62
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 2
    end
    object edtNomPorBai: TEdit
      Left = 64
      Top = 83
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 3
    end
    object edtNosNum: TEdit
      Left = 64
      Top = 104
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 4
    end
    object edtHistor: TEdit
      Left = 64
      Top = 125
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 5
    end
    object edtHistor2: TEdit
      Left = 64
      Top = 146
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 6
    end
    object edtDesProtesta: TEdit
      Left = 64
      Top = 167
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 7
    end
    object edtCodVel: TEdit
      Left = 64
      Top = 188
      Width = 310
      Height = 19
      AutoSize = False
      Enabled = False
      TabOrder = 8
    end
  end
  object dbgDuplicatas: TcxGridCitel [6]
    Left = 0
    Top = 22
    Width = 886
    Height = 436
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgDuplicatasTableView1: TcxGridDBTableViewCitel
      OnKeyDown = dbgDuplicatasTableView1KeyDown
      OnKeyUp = dbgDuplicatasTableView1KeyUp
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = dbgDuplicatasTableView1CellClick
      OnCellDblClick = dbgDuplicatasTableView1CellDblClick
      OnCustomDrawCell = dbgDuplicatasTableView1CustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object dbgDuplicatasTableView1CTR_NUMDUP: TcxGridDBColumn
        Caption = 'Duplicata'
        DataBinding.FieldName = 'CTR_NUMDUP1'
        MinWidth = 25
        Options.Editing = False
        Width = 86
      end
      object dbgDuplicatasTableView1CTR_ESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'CTR_ESPDOC'
        MinWidth = 50
        Options.Editing = False
        Options.AutoWidthSizable = False
      end
      object dbgDuplicatasTableView1CTR_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CTR_CODEMP'
        MinWidth = 50
        Options.Editing = False
        Options.AutoWidthSizable = False
      end
      object dbgDuplicatasTableView1CTR_CLIENTE: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CTR_CLIENTE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 160
      end
      object dbgDuplicatasTableView1CTR_DTAVEN: TcxGridDBColumn
        Caption = 'Vencimento'
        DataBinding.FieldName = 'CTR_DTAVEN'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 77
      end
      object dbgDuplicatasTableView1CTR_DTAREC: TcxGridDBColumn
        Caption = 'Recebimento'
        DataBinding.FieldName = 'CTR_DTAREC'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 80
      end
      object dbgDuplicatasTableView1CTR_VALDUP: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'CTR_VALDUP'
        Options.Editing = False
        Width = 81
      end
      object dbgDuplicatasTableView1OCORRENCIA: TcxGridDBColumn
        Caption = 'Ocorr'#234'ncia'
        DataBinding.FieldName = 'OCORRENCIA'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.OnChange = dbgDuplicatasTableView1OCORRENCIAPropertiesChange
        Width = 110
      end
      object dbgDuplicatasTableView1CTR_MARCAD: TcxGridDBColumn
        DataBinding.FieldName = 'CTR_MARCAD'
        Visible = False
        Options.Editing = False
      end
      object dbgDuplicatasTableView1CTR_CODEVE: TcxGridDBColumn
        Caption = 'Centro de Custos'
        DataBinding.FieldName = 'CTR_CODEVE'
        MinWidth = 170
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 170
      end
    end
    object dbgDuplicatasLevel1: TcxGridLevel
      GridView = dbgDuplicatasTableView1
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 128
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 216
    Top = 64
  end
  object cxEditRepository: TcxEditRepository
    Left = 272
    Top = 152
    PixelsPerInch = 96
    object imgcbxOcorrencia: TcxEditRepositoryImageComboBoxItem
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items = <
        item
          Description = 'TESTE 1'
          ImageIndex = 0
          Value = ''
        end
        item
          Description = 'TESTE2'
          Value = ''
        end>
    end
  end
end
