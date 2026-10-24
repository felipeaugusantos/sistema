inherited frmEntDigMultiLojas: TfrmEntDigMultiLojas
  Left = 152
  Top = 221
  Width = 1150
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Digita'#231#227'o de Quantidades'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnResize = FormResize
  ExplicitWidth = 1150
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object splGrid: TSplitter [0]
    Left = 0
    Top = 301
    Width = 1134
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    Color = clGreen
    ParentColor = False
    Visible = False
    ExplicitTop = 425
    ExplicitWidth = 876
  end
  inherited pnlBotoes: TPanel
    Top = 511
    Width = 1134
    Height = 35
    ExplicitTop = 511
    ExplicitWidth = 1134
    ExplicitHeight = 35
    object Label6: TLabel [0]
      Left = 613
      Top = 6
      Width = 86
      Height = 14
      Caption = 'Empresa corrente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape [1]
      Left = 597
      Top = 8
      Width = 12
      Height = 12
      Brush.Color = clMoneyGreen
      Pen.Color = clWhite
    end
    object Label1: TLabel [2]
      Left = 116
      Top = 3
      Width = 160
      Height = 14
      Caption = '[F2] Giro de estoque anal'#237'tico'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label5: TLabel [3]
      Left = 316
      Top = 3
      Width = 250
      Height = 14
      Caption = '(C) Compra Centralizada (I) Compra Individual'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label7: TLabel [4]
      Left = 116
      Top = 17
      Width = 191
      Height = 14
      Caption = '[F3] Pedidos de Vendas em Aberto'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel [5]
      Left = 316
      Top = 17
      Width = 128
      Height = 14
      Caption = '[F5] Prepara'#231#227'o para TE'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    inherited btnSair: TBitBtnLocked
      Left = 1055
      Top = 2
      Height = 31
      Align = alRight
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 1055
      ExplicitTop = 2
      ExplicitHeight = 31
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 108
      Height = 31
      Align = alLeft
      Caption = '[F10] &Confirma'
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
    Top = 546
    Width = 1134
    ExplicitTop = 546
    ExplicitWidth = 1134
    inherited pnlNomeForm: TPanel
      Left = 963
      ExplicitLeft = 963
    end
    inherited pnlInfo: TPanel
      Width = 963
      ExplicitWidth = 963
    end
  end
  object pnlTotais: TPanel [3]
    Left = 0
    Top = 428
    Width = 1134
    Height = 83
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblMaQtSa: TLabel
      Left = 517
      Top = 0
      Width = 85
      Height = 14
      Caption = 'Maior venda: Qtd.'
    end
    object lblMaDtSa: TLabel
      Left = 607
      Top = 0
      Width = 22
      Height = 14
      Caption = 'Data'
    end
    object Label4: TLabel
      Left = 450
      Top = 0
      Width = 62
      Height = 14
      Caption = 'Mult. Compra'
    end
    object lblQtdPen: TLabel
      Left = 352
      Top = 1
      Width = 92
      Height = 14
      Caption = 'Qtd.Ped.Com.Pend.'
    end
    object dbeMaQtSa: TDBEditFocus
      Left = 517
      Top = 14
      Width = 89
      Height = 22
      DataField = 'ITE_MAQTSA'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMaDtSa: TDBEditFocus
      Left = 607
      Top = 14
      Width = 71
      Height = 22
      DataField = 'ITE_MADTSA'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMltCom: TDBEditFocus
      Left = 450
      Top = 14
      Width = 67
      Height = 22
      DataField = 'ITE_MLTCOM'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdPen: TDBEditFocus
      Left = 350
      Top = 14
      Width = 92
      Height = 22
      TabStop = False
      DataField = 'ITE_QTDPEN'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlMeses: TPanel
      Left = 0
      Top = 0
      Width = 329
      Height = 83
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 4
      object lblQtdM04: TLabel
        Left = 3
        Top = 0
        Width = 47
        Height = 14
        Caption = 'lblQtdM04'
        Visible = False
      end
      object lblQtdM05: TLabel
        Left = 64
        Top = 0
        Width = 47
        Height = 14
        Caption = 'lblQtdM05'
        Visible = False
      end
      object lblQtdM06: TLabel
        Left = 125
        Top = 0
        Width = 47
        Height = 14
        Caption = 'lblQtdM06'
        Visible = False
      end
      object lblQtdM07: TLabel
        Left = 187
        Top = 0
        Width = 47
        Height = 14
        Caption = 'lblQtdM07'
        Visible = False
      end
      object lblQtdM08: TLabel
        Left = 3
        Top = 40
        Width = 47
        Height = 14
        Caption = 'lblQtdM08'
        Visible = False
      end
      object lblQtdM09: TLabel
        Left = 64
        Top = 41
        Width = 47
        Height = 14
        Caption = 'lblQtdM09'
        Visible = False
      end
      object lblQtdM10: TLabel
        Left = 125
        Top = 41
        Width = 47
        Height = 14
        Caption = 'lblQtdM10'
        Visible = False
      end
      object lblQtdM11: TLabel
        Left = 187
        Top = 41
        Width = 46
        Height = 14
        Caption = 'lblQtdM11'
        Visible = False
      end
      object lblQtdM12: TLabel
        Left = 248
        Top = 41
        Width = 47
        Height = 14
        Caption = 'lblQtdM12'
        Visible = False
      end
      object dbeQtdM04: TDBEditFocus
        Left = 3
        Top = 14
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdM05: TDBEditFocus
        Left = 64
        Top = 14
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdM06: TDBEditFocus
        Left = 125
        Top = 14
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdM07: TDBEditFocus
        Left = 187
        Top = 14
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdM08: TDBEditFocus
        Left = 3
        Top = 54
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdM09: TDBEditFocus
        Left = 64
        Top = 55
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdM10: TDBEditFocus
        Left = 125
        Top = 55
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdM11: TDBEditFocus
        Left = 187
        Top = 55
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeQtdM12: TDBEditFocus
        Left = 248
        Top = 55
        Width = 60
        Height = 22
        DataSource = dtsPcdDet
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 273
    Width = 1134
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 3
    object Label30: TLabel
      Left = 7
      Top = 7
      Width = 82
      Height = 14
      Caption = #218'ltima compra:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label31: TLabel
      Left = 167
      Top = 7
      Width = 67
      Height = 14
      Caption = 'Fornecedor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label32: TLabel
      Left = 533
      Top = 7
      Width = 65
      Height = 14
      Caption = 'Quantidade:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label34: TLabel
      Left = 677
      Top = 7
      Width = 31
      Height = 14
      Caption = 'Valor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEditFocus1: TDBEditFocus
      Left = 95
      Top = 3
      Width = 65
      Height = 22
      TabStop = False
      DataField = 'ITE_DTAULT'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus2: TDBEditFocus
      Left = 237
      Top = 3
      Width = 283
      Height = 22
      TabStop = False
      DataField = 'ITE_NOMFOR'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus3: TDBEditFocus
      Left = 602
      Top = 3
      Width = 65
      Height = 22
      TabStop = False
      DataField = 'ITE_QTDUCO'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus5: TDBEditFocus
      Left = 714
      Top = 3
      Width = 65
      Height = 22
      TabStop = False
      DataField = 'ITE_PREULT'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object TPanel [5]
    Left = 0
    Top = 237
    Width = 1134
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 4
    object Label3: TLabel
      Left = 20
      Top = 10
      Width = 69
      Height = 14
      Caption = 'Local. F'#237'sica:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label39: TLabel
      Left = 563
      Top = 3
      Width = 219
      Height = 27
      AutoSize = False
      Caption = 
        'Somente os meses em vermelho foram considerados para a m'#233'dia e s' +
        'ugest'#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object DBEditFocus4: TDBEditFocus
      Left = 95
      Top = 6
      Width = 139
      Height = 22
      TabStop = False
      DataField = 'ITE_LOCFIS'
      DataSource = dtsPcdDet
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGrid [6]
    Left = 0
    Top = 0
    Width = 1134
    Height = 237
    Align = alClient
    TabOrder = 5
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataSource = dtsPcdDet
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          FieldName = 'ITE_ESTMAX'
          Column = cxgItensESTMAX
        end
        item
          Kind = skSum
          FieldName = 'ITE_MEDIA_'
          Column = cxgItensMEDIA_
        end
        item
          Kind = skSum
          FieldName = 'ITE_MEDIXX'
          Column = cxgItensMEDIXX
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_01'
          Column = cxgItensQ_V_01
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_02'
          Column = cxgItensQ_V_02
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_03'
          Column = cxgItensQ_V_03
        end
        item
          Kind = skSum
          FieldName = 'ITE_QTDITE'
          Column = cxgItensQTDITE
        end
        item
          Kind = skSum
          FieldName = 'ITE_SUGEST'
          Column = cxgItensSUGEST
        end
        item
          Kind = skSum
          FieldName = 'ITE_VENMES'
          Column = cxgItensVENMES
        end
        item
          Kind = skSum
          FieldName = 'ITE_SALDOS'
          Column = cxgItensSALDOS
        end
        item
          Kind = skSum
          FieldName = 'ITE_ESTMAX'
          Column = cxgItensESTMAX
        end
        item
          Kind = skSum
          FieldName = 'ITE_ESTMIN'
          Column = cxgItensESTMIN
        end
        item
          Kind = skSum
          OnGetText = cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems12GetText
          FieldName = 'ITE_DIAEST'
          Column = cxgItensDIAEST
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_04'
          Column = cxgItensQ_V_04
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_05'
          Column = cxgItensQ_V_05
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_06'
          Column = cxgItensQ_V_06
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_07'
          Column = cxgItensQ_V_07
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_08'
          Column = cxgItensQ_V_08
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_09'
          Column = cxgItensQ_V_09
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_10'
          Column = cxgItensQ_V_10
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_11'
          Column = cxgItensQ_V_11
        end
        item
          Kind = skSum
          FieldName = 'ITE_Q_V_12'
          Column = cxgItensQ_V_12
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.AlwaysShowEditor = True
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      object cxgItensCODEMP: TcxGridDBColumn
        Caption = 'Emp'
        DataBinding.FieldName = 'ITE_CODEMP'
        Options.Editing = False
        Width = 36
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_CPCEMO'
        Options.Editing = False
        Width = 20
        IsCaptionAssigned = True
      end
      object cxgItensDESEMP: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESEMP'
        Options.Editing = False
        Width = 74
      end
      object cxgItensQ_V_12: TcxGridDBColumn
        Caption = 'M'#234's 012'
        DataBinding.FieldName = 'ITE_Q_V_12'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_11: TcxGridDBColumn
        Caption = 'M'#234's 011'
        DataBinding.FieldName = 'ITE_Q_V_11'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_10: TcxGridDBColumn
        Caption = 'M'#234's 010'
        DataBinding.FieldName = 'ITE_Q_V_10'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_09: TcxGridDBColumn
        Caption = 'M'#234's 009'
        DataBinding.FieldName = 'ITE_Q_V_09'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_08: TcxGridDBColumn
        Caption = 'M'#234's 008'
        DataBinding.FieldName = 'ITE_Q_V_08'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_07: TcxGridDBColumn
        Caption = 'M'#234's 007'
        DataBinding.FieldName = 'ITE_Q_V_07'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_06: TcxGridDBColumn
        Caption = 'M'#234's 006'
        DataBinding.FieldName = 'ITE_Q_V_06'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_05: TcxGridDBColumn
        Caption = 'M'#234's 005'
        DataBinding.FieldName = 'ITE_Q_V_05'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_04: TcxGridDBColumn
        Caption = 'M'#234's 004'
        DataBinding.FieldName = 'ITE_Q_V_04'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_03: TcxGridDBColumn
        Caption = 'M'#234's 003'
        DataBinding.FieldName = 'ITE_Q_V_03'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_02: TcxGridDBColumn
        Caption = 'M'#234's 002'
        DataBinding.FieldName = 'ITE_Q_V_02'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensQ_V_01: TcxGridDBColumn
        Caption = 'M'#234's 001'
        DataBinding.FieldName = 'ITE_Q_V_01'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensVENMES: TcxGridDBColumn
        Caption = 'M'#234's'
        DataBinding.FieldName = 'ITE_VENMES'
        OnCustomDrawCell = cxgItensVENMESCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensMEDIA_: TcxGridDBColumn
        Caption = 'M'#233'dia'
        DataBinding.FieldName = 'ITE_MEDIA_'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensMEDIXX: TcxGridDBColumn
        Caption = 'M'#233'dia XX'
        DataBinding.FieldName = 'ITE_MEDIXX'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensSUGEST: TcxGridDBColumn
        Caption = 'Sugest'#227'o'
        DataBinding.FieldName = 'ITE_SUGEST'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensESTMIN: TcxGridDBColumn
        Caption = 'Est. M'#237'n.'
        DataBinding.FieldName = 'ITE_ESTMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000;-0.000'
        HeaderAlignmentHorz = taRightJustify
        Width = 59
      end
      object cxgItensESTMAX: TcxGridDBColumn
        Caption = 'Est. M'#225'x.'
        DataBinding.FieldName = 'ITE_ESTMAX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000;-0.000'
        HeaderAlignmentHorz = taRightJustify
        Width = 59
      end
      object cxgItensSALDOS: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'ITE_SALDOS'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 59
      end
      object cxgItensDIAEST: TcxGridDBColumn
        Caption = 'Dias Estoq.'
        DataBinding.FieldName = 'ITE_DIAEST'
        FooterAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 60
      end
      object cxgItensNIVGIR: TcxGridDBColumn
        Caption = 'N'#237'vel Giro'
        DataBinding.FieldName = 'ITE_NVLGIR'
        Options.Editing = False
        Width = 55
      end
      object cxgItensQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ITE_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 68
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object cxgGiro: TcxGrid [7]
    Left = 0
    Top = 305
    Width = 1134
    Height = 123
    Align = alBottom
    TabOrder = 6
    Visible = False
    object cxgGiroView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          OnGetText = cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems12GetText
          Column = cxgGiroDIAEST
        end
        item
          Kind = skSum
          Column = cxgGiroMES001
        end
        item
          Kind = skSum
          Column = cxgGiroMES002
        end
        item
          Kind = skSum
          Column = cxgGiroMES003
        end
        item
          Kind = skSum
          Column = cxgGiroMES004
        end
        item
          Kind = skSum
          Column = cxgGiroMES005
        end
        item
          Kind = skSum
          Column = cxgGiroMES006
        end
        item
          Kind = skSum
          Column = cxgGiroMES007
        end
        item
          Kind = skSum
          Column = cxgGiroMES008
        end
        item
          Kind = skSum
          Column = cxgGiroMES009
        end
        item
          Kind = skSum
          Column = cxgGiroMES010
        end
        item
          Kind = skSum
          Column = cxgGiroMES011
        end
        item
          Kind = skSum
          Column = cxgGiroMES012
        end
        item
          Kind = skSum
          FieldName = 'ITE_MEDIA_'
          Column = cxgGiroMEDIA_
        end
        item
          Kind = skSum
          Column = cxgGiroVENMES
        end
        item
          Kind = skSum
          Column = cxgGiroSUGEST
        end
        item
          Kind = skSum
          Column = cxgGiroSALDOS
        end
        item
          Kind = skSum
          Column = cxgGiroQTDPEN
        end
        item
          Kind = skSum
          Column = cxgGiroSALGAR
        end
        item
          Kind = skSum
          Column = cxgGiroSALRES
        end
        item
          Kind = skSum
          Column = cxgGiroDIAEST
        end
        item
          Kind = skSum
          Column = cxgGiroESTMIN
        end
        item
          Format = ' '
          Kind = skMax
          Column = cxgGiroDTAULT
        end
        item
          Format = ' '
          Kind = skMax
          Column = cxgGiroDTAUVE
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Styles.ContentOdd = cxStyle1
      object cxgGiroCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'ITE_CODEMP'
        HeaderAlignmentHorz = taCenter
        SortIndex = 0
        SortOrder = soAscending
        Width = 68
      end
      object cxgGiroMES001: TcxGridDBColumn
        Caption = 'M'#234's 1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES001CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES002: TcxGridDBColumn
        Caption = 'M'#234's 2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES002CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES003: TcxGridDBColumn
        Caption = 'M'#234's 3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES003CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES004: TcxGridDBColumn
        Caption = 'M'#234's 4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES004CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES005: TcxGridDBColumn
        Caption = 'M'#234's 5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES005CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES006: TcxGridDBColumn
        Caption = 'M'#234's 6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES006CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES007: TcxGridDBColumn
        Caption = 'M'#234's 7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES007CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES008: TcxGridDBColumn
        Caption = 'M'#234's 8'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES008CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES009: TcxGridDBColumn
        Caption = 'M'#234's 9'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES009CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES010: TcxGridDBColumn
        Caption = 'M'#234's 10'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES010CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES011: TcxGridDBColumn
        Caption = 'M'#234's 11'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES011CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMES012: TcxGridDBColumn
        Caption = 'M'#234's 12'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroMES012CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroVENMES: TcxGridDBColumn
        Caption = 'M'#234's Atual'
        DataBinding.FieldName = 'ITE_VENMES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxgGiroVENMESCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgGiroMEDIA_: TcxGridDBColumn
        Caption = 'M'#233'dia Vendas'
        DataBinding.FieldName = 'ITE_MEDIA_'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Width = 77
      end
      object cxgGiroSUGEST: TcxGridDBColumn
        Caption = 'Sugest'#227'o Compra'
        DataBinding.FieldName = 'ITE_SUGEST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 100
      end
      object cxgGiroMLTCOM: TcxGridDBColumn
        Caption = 'M'#250'lt. Compra'
        DataBinding.FieldName = 'ITE_MLTCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxgGiroSALDOS: TcxGridDBColumn
        Caption = 'Saldo Estoque'
        DataBinding.FieldName = 'ITE_SALDOS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 90
      end
      object cxgGiroQTDPEN: TcxGridDBColumn
        Caption = 'Qtd. Pendente'
        DataBinding.FieldName = 'ITE_QTDPEN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 91
      end
      object cxgGiroSALGAR: TcxGridDBColumn
        Caption = 'Saldo Res. Garantia'
        DataBinding.FieldName = 'ITE_SALGAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 113
      end
      object cxgGiroSALRES: TcxGridDBColumn
        Caption = 'Saldo Res. PD'
        DataBinding.FieldName = 'ITE_SALRES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 86
      end
      object cxgGiroDIAEST: TcxGridDBColumn
        Caption = 'Dias Estoque'
        DataBinding.FieldName = 'ITE_DIAEST'
        HeaderAlignmentHorz = taRightJustify
        Width = 75
      end
      object cxgGiroLOCFIS: TcxGridDBColumn
        Caption = 'Local. F'#237'sica'
        DataBinding.FieldName = 'ITE_LOCFIS'
        Width = 89
      end
      object cxgGiroESTMIN: TcxGridDBColumn
        Caption = 'Estoque M'#237'nimo'
        DataBinding.FieldName = 'ITE_ESTMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 89
      end
      object cxgGiroDTAULT: TcxGridDBColumn
        Caption = 'Data '#218'lt. Compra'
        DataBinding.FieldName = 'ITE_DTAULT'
        HeaderAlignmentHorz = taCenter
        Width = 93
      end
      object cxgGiroNOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor da '#218'ltima Compra'
        DataBinding.FieldName = 'ITE_NOMFOR'
        Width = 206
      end
      object cxgGiroQTDUCO: TcxGridDBColumn
        Caption = 'Quant. '#218'lt. Compra'
        DataBinding.FieldName = 'ITE_QTDUCO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 98
      end
      object cxgGiroPREULT: TcxGridDBColumn
        Caption = 'Pre'#231'o '#218'lt. Compra'
        DataBinding.FieldName = 'ITE_PREULT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 98
      end
      object cxgGiroDTAUVE: TcxGridDBColumn
        Caption = 'Data '#218'lt. Venda'
        DataBinding.FieldName = 'ITE_DTAUVE'
        HeaderAlignmentHorz = taCenter
        Width = 87
      end
      object cxgGiroDIAUCO: TcxGridDBColumn
        Caption = #218'ltima Compra (Dias)'
        DataBinding.FieldName = 'ITE_DIAUCO'
        HeaderAlignmentHorz = taRightJustify
        Width = 108
      end
      object cxgGiroDIAUVE: TcxGridDBColumn
        Caption = #218'ltima Venda (Dias)'
        DataBinding.FieldName = 'ITE_DIAUVE'
        HeaderAlignmentHorz = taRightJustify
        Width = 103
      end
      object cxgGiroNIVGIR: TcxGridDBColumn
        Caption = 'N'#237'vel Giro'
        DataBinding.FieldName = 'ITE_NVLGIR'
        Options.Editing = False
        Width = 55
      end
    end
    object cxgGiroLevel1: TcxGridLevel
      GridView = cxgGiroView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 200
    Top = 144
  end
  object dtsPcdDet: TDataSource
    Left = 56
    Top = 96
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
