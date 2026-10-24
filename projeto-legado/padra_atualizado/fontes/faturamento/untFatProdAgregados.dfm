inherited frmFatProdAgregados: TfrmFatProdAgregados
  Left = 470
  Top = 247
  Width = 1040
  Height = 315
  Caption = 'Produtos Agregados'
  Position = poMainFormCenter
  OnResize = FormResize
  ExplicitWidth = 1040
  ExplicitHeight = 315
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 242
    Width = 1034
    TabOrder = 3
    ExplicitTop = 242
    ExplicitWidth = 1034
    object lblLegenda: TLabel [0]
      Left = 456
      Top = 6
      Width = 481
      Height = 14
      Alignment = taCenter
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = '(*) = Pai ou Filho'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 96
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1030
      TabOrder = 2
      ExplicitWidth = 1030
    end
    inherited btnSair: TBitBtnLocked
      Left = 951
      ExplicitLeft = 951
    end
    object btnGravar: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 77
      Height = 22
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
      OnClick = btnGravarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 270
    Width = 1034
    ExplicitTop = 270
    ExplicitWidth = 1034
    inherited pnlNomeForm: TPanel
      Left = 863
      ExplicitLeft = 863
    end
    inherited pnlInfo: TPanel
      Width = 863
      ExplicitWidth = 863
    end
  end
  object pnlDescricaoItem: TPanel [2]
    Left = 0
    Top = 213
    Width = 1034
    Height = 29
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    BorderWidth = 5
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object lblDesIteTit: TLabel
      Left = 5
      Top = 7
      Width = 51
      Height = 15
      Caption = 'Produto: '
    end
    object lblDesIte: TLabel
      Left = 59
      Top = 7
      Width = 531
      Height = 15
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object shpInfLot: TShape
      Left = 897
      Top = 6
      Width = 49
      Height = 17
      Brush.Color = 11599871
    end
    object lblInfLot: TLabel
      Left = 952
      Top = 6
      Width = 73
      Height = 15
      Caption = 'Informar Lote'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 1034
    Height = 213
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgItensTableViewKeyDown
      OnKeyPress = cxgItensTableViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensTableViewCustomDrawCell
      OnEditKeyDown = cxgItensTableViewEditKeyDown
      OnEditKeyPress = cxgItensTableViewEditKeyPress
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object CODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 50
      end
      object DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 209
      end
      object NUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
      end
      object REFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Options.Editing = False
        Width = 70
      end
      object UNIDAD: TcxGridDBColumn
        Caption = 'Un'
        DataBinding.FieldName = 'UNIDAD'
        Options.Editing = False
        Width = 22
      end
      object DESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'DESMAR'
        Options.Editing = False
        Width = 60
      end
      object CODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'b.'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Width = 60
      end
      object SALDOS: TcxGridDBColumn
        Caption = 'Estoque'
        DataBinding.FieldName = 'SALDOS'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object SALDIS: TcxGridDBColumn
        Caption = 'Est. Disp.'
        DataBinding.FieldName = 'SALDIS'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object QTDITE: TcxGridDBColumn
        Caption = 'Qtd.'
        DataBinding.FieldName = 'QTDITE'
        Width = 55
      end
      object UNITAR: TcxGridDBColumn
        Caption = 'Vl. Unit.'
        DataBinding.FieldName = 'UNITAR'
        Options.Editing = False
        Width = 69
      end
      object PERDES: TcxGridDBColumn
        Caption = '% Desc.'
        DataBinding.FieldName = 'PERDES'
        Width = 50
      end
      object TOTITE: TcxGridDBColumn
        Caption = 'Total'
        DataBinding.FieldName = 'TOTITE'
        Options.Editing = False
        Width = 60
      end
      object PAIFIL: TcxGridDBColumn
        Caption = 'Item (*)'
        DataBinding.FieldName = 'PAIFIL'
        Options.Editing = False
        Width = 40
      end
      object SITUAC: TcxGridDBColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'SITUAC'
        Options.Editing = False
        Width = 50
      end
      object COMPLE: TcxGridDBColumn
        Caption = 'Complemento'
        DataBinding.FieldName = 'COMPLE'
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 600
    Top = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 136
  end
end
