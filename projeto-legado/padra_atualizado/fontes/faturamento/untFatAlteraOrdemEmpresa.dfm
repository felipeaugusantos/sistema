inherited frmFatAlteraOrdemEmpresa: TfrmFatAlteraOrdemEmpresa
  Width = 751
  Height = 376
  Caption = 'Alterar Ordem das Empresas'
  OnDestroy = FormDestroy
  ExplicitWidth = 751
  ExplicitHeight = 376
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 300
    Width = 745
    Height = 31
    BevelInner = bvNone
    BevelOuter = bvRaised
    BorderWidth = 2
    Color = 16770261
    TabOrder = 2
    ExplicitTop = 186
    ExplicitHeight = 31
    inherited FlwBotoes: TFlowPanel
      Left = 3
      Top = 3
      Width = 739
      Height = 25
      Color = 16770261
      ParentBackground = False
      ExplicitLeft = 3
      ExplicitTop = 3
      ExplicitWidth = 739
      ExplicitHeight = 25
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 107
        Height = 25
        Align = alLeft
        Caption = '[F10] Confirmar'
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
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 662
      Top = 6
      Caption = 'Sair'
    end
  end
  inherited pnlStatus: TPanel
    Top = 331
    Width = 745
    TabOrder = 3
    inherited pnlNomeForm: TPanel
      Left = 574
    end
    inherited pnlInfo: TPanel
      Width = 574
    end
  end
  object cxgEmpresas: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 745
    Height = 277
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = -525
    ExplicitTop = -237
    ExplicitWidth = 1008
    ExplicitHeight = 470
    object cxgEmpresasView: TcxGridDBTableView
      OnKeyDown = cxgEmpresasViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsEmpresas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.GroupByBox = False
      object cxgEmpresasORDEM_: TcxGridDBColumn
        Caption = 'Ordem'
        DataBinding.FieldName = 'ORDEM_'
      end
      object cxgEmpresasCODEMP: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODEMP'
        Width = 68
      end
      object cxgEmpresasNOMEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'NOMEMP'
        Width = 576
      end
    end
    object cxgEmpresasLevel1: TcxGridLevel
      GridView = cxgEmpresasView
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 277
    Width = 745
    Height = 23
    Align = alBottom
    Caption = 
      'Para ordenar as empresas selecione a mesma pressione Ctrl + seta' +
      ' para baixo ou para cima'
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 276
  end
  object dtsEmpresas: TDataSource
    DataSet = cdsEmpresas
    Left = 632
    Top = 64
  end
  object cdsEmpresas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 560
    Top = 64
    object cdsEmpresasORDEM_: TIntegerField
      FieldName = 'ORDEM_'
    end
    object cdsEmpresasCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsEmpresasNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 70
    end
  end
end
