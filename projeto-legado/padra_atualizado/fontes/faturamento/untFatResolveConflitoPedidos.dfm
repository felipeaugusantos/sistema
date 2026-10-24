inherited frmFatResolveConflitoPedidos: TfrmFatResolveConflitoPedidos
  Width = 796
  Height = 527
  BorderIcons = [biSystemMenu]
  Caption = 'Resolve Conflito de Pedidos'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 796
  ExplicitHeight = 527
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 454
    Width = 790
    ExplicitTop = 454
    ExplicitWidth = 790
    object lblLegenda: TLabel [0]
      Left = 84
      Top = 6
      Width = 617
      Height = 14
      Caption = 
        '(*) Condi'#231#227'o ser'#225' ajustada conforme defini'#231#245'es de "Dia Fixo" (Ca' +
        'dastro Cliente), "Tipo Fora" (Cadastro Condi'#231#227'o)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 786
      TabOrder = 2
    end
    inherited btnSair: TBitBtnLocked
      Left = 707
      ExplicitLeft = 707
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
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
      OnClick = btnConfirmaDadosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 482
    Width = 790
    ExplicitTop = 482
    ExplicitWidth = 790
    inherited pnlNomeForm: TPanel
      Left = 619
      ExplicitLeft = 619
    end
    inherited pnlInfo: TPanel
      Width = 619
      ExplicitWidth = 619
    end
  end
  object pnlGridPedidos: TPanel [3]
    Left = 0
    Top = 0
    Width = 790
    Height = 374
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object cxgGriidCitel: TcxGridCitel
      Left = 0
      Top = 0
      Width = 790
      Height = 374
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgGriidCitelTableView1: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsPedidos
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
      end
      object cxgGriidCitelLevel1: TcxGridLevel
        GridView = cxgGriidCitelTableView1
      end
    end
  end
  object pnlConflitos: TPanel [4]
    Left = 0
    Top = 374
    Width = 790
    Height = 80
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object pgcConflitos: TPageControl
      Left = 0
      Top = 0
      Width = 790
      Height = 80
      ActivePage = tbsCondicao
      Align = alClient
      TabOrder = 0
      object tbsTransportadoras: TTabSheet
        Caption = 'Transportadora'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label1: TLabel
          Left = 12
          Top = 23
          Width = 106
          Height = 14
          Caption = 'Nova Transportadora:'
        end
        object edtCodTra: TEditFocus
          Tag = 99
          Left = 123
          Top = 19
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodTraKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomTra: TEditFocus
          Left = 186
          Top = 19
          Width = 295
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object tbsCondicao: TTabSheet
        Caption = 'Condi'#231#227'o / Forma de Pagamento'
        ImageIndex = 1
        object Label2: TLabel
          Left = 12
          Top = 23
          Width = 97
          Height = 14
          Caption = 'Condi'#231#227'o Escolhida:'
        end
        object Label3: TLabel
          Left = 460
          Top = 23
          Width = 82
          Height = 14
          Caption = 'Forma Escolhida:'
        end
        object cmbConPag: TComboBoxFocus
          Tag = 99
          Left = 115
          Top = 19
          Width = 326
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          OnCloseUp = cmbConPagCloseUp
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtForPag: TEditFocus
          Left = 546
          Top = 19
          Width = 223
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    end
  end
  object dtsPedidos: TDataSource
    Left = 512
    Top = 184
  end
end
