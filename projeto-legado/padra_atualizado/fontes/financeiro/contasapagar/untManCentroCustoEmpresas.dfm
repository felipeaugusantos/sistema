inherited frmManCentroCustoEmpresas: TfrmManCentroCustoEmpresas
  Width = 506
  Height = 349
  BorderIcons = [biSystemMenu]
  Caption = 'Rateio entre as Empresas'
  Position = poMainFormCenter
  ExplicitWidth = 506
  ExplicitHeight = 349
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 276
    Width = 500
    ExplicitTop = 276
    ExplicitWidth = 500
    inherited FlwBotoes: TFlowPanel
      Left = 79
      Width = 342
      TabOrder = 2
      ExplicitLeft = 79
      ExplicitWidth = 342
    end
    inherited btnSair: TBitBtnLocked
      Left = 421
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 421
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 77
      Height = 24
      Align = alLeft
      Caption = '&Gravar'
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
    Top = 304
    Width = 500
    ExplicitTop = 304
    ExplicitWidth = 500
    inherited pnlNomeForm: TPanel
      Left = 329
      ExplicitLeft = 329
    end
    inherited pnlInfo: TPanel
      Width = 329
      ExplicitWidth = 329
    end
  end
  object dbgrdEmpresas: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 500
    Height = 243
    Align = alClient
    DataSource = dtsEmpresas
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgrdEmpresasDrawColumnCell
    OnKeyDown = dbgrdEmpresasKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODEMP'
        ReadOnly = True
        Title.Caption = 'C'#243'd. Emp.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMEMP'
        ReadOnly = True
        Title.Caption = 'Nome Empresa'
        Width = 333
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PEREMP'
        Title.Caption = 'Percentual'
        Width = 65
        Visible = True
      end>
  end
  object pnlTotais: TPanel [3]
    Left = 0
    Top = 243
    Width = 500
    Height = 33
    Align = alBottom
    Color = 16770261
    TabOrder = 3
    object lbl1: TLabel
      Left = 352
      Top = 9
      Width = 25
      Height = 14
      Caption = 'Total:'
    end
    object dbeTotPer: TDBEdit
      Left = 387
      Top = 5
      Width = 77
      Height = 22
      DataField = 'TOTPER'
      DataSource = dtsEmpresas
      ReadOnly = True
      TabOrder = 0
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 80
  end
  object dtsEmpresas: TDataSource
    DataSet = cdsEmpresas
    Left = 256
    Top = 80
  end
  object cdsEmpresas: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 288
    Top = 80
    object cdsEmpresasCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsEmpresasNOMEMP: TStringField
      FieldName = 'NOMEMP'
      Size = 60
    end
    object cdsEmpresasPEREMP: TFloatField
      FieldName = 'PEREMP'
      DisplayFormat = ',0.00%'
      EditFormat = ',0.00'
    end
    object cdsEmpresasEMPATI: TStringField
      FieldName = 'EMPATI'
      Size = 1
    end
    object cdsEmpresasTOTPER: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TOTPER'
      Active = True
      DisplayName = ''
      DisplayFormat = ',0.00%'
      Expression = 'SUM(PEREMP)'
    end
  end
end
