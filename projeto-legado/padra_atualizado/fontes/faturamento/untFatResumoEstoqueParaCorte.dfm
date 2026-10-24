inherited frmFatResumoEstoqueParaCorte: TfrmFatResumoEstoqueParaCorte
  Width = 798
  Height = 440
  BorderIcons = [biSystemMenu]
  Caption = 'Resumo de Itens sem estoque para corte'
  Position = poOwnerFormCenter
  OnClose = FormClose
  ExplicitWidth = 798
  ExplicitHeight = 440
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 352
    Width = 792
    Height = 43
    TabOrder = 3
    ExplicitTop = 352
    ExplicitWidth = 792
    ExplicitHeight = 43
    object lblLeg: TLabel [0]
      Left = 5
      Top = 1
      Width = 654
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 
        '(*) S'#243' ser'#225' exibido quando o mesmo foi utilizado para o corte ou' +
        ' a quantidade cortada n'#227'o '#233' m'#250'ltiplo de venda.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label4: TLabel [1]
      Left = 113
      Top = 20
      Width = 364
      Height = 18
      Alignment = taRightJustify
      Caption = '[Barra de Espa'#231'o -Marca itens para retirar do corte]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 673
      Height = 0
      Align = alNone
      TabOrder = 2
      ExplicitWidth = 673
      ExplicitHeight = 0
    end
    inherited btnSair: TBitBtnLocked
      Left = 709
      Top = 18
      ExplicitLeft = 709
      ExplicitTop = 18
    end
    object btnConfirma: TBitBtnLocked
      Left = 3
      Top = 18
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
      OnClick = btnConfirmaClick
    end
    object btnRetCor: TBitBtnLocked
      Left = 504
      Top = 18
      Width = 205
      Height = 22
      Caption = '[ F2 ] Retirar todos os itens do corte'
      TabOrder = 3
      OnClick = btnRetCorClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 395
    Width = 792
    TabOrder = 4
    ExplicitTop = 395
    ExplicitWidth = 792
    inherited pnlNomeForm: TPanel
      Left = 621
      ExplicitLeft = 621
    end
    inherited pnlInfo: TPanel
      Width = 621
      ExplicitWidth = 621
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 792
    Height = 300
    Align = alClient
    DataSource = dtsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 346
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODUNI'
        Title.Caption = 'Unidade'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MLTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'M'#250'ltiplo Venda (*)'
        Visible = True
      end>
  end
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 300
    Width = 792
    Height = 31
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lblTotImp: TLabel
      Left = 471
      Top = 9
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label1: TLabel
      Left = 268
      Top = 9
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total sem estoque:'
    end
    object Label2: TLabel
      Left = 68
      Top = 9
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total com estoque:'
    end
    object edtTotImp: TEditFocus
      Left = 529
      Top = 5
      Width = 100
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      AutoSize = False
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtTotSemEst: TEditFocus
      Left = 361
      Top = 5
      Width = 100
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      AutoSize = False
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtTotComEst: TEditFocus
      Left = 161
      Top = 5
      Width = 100
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      AutoSize = False
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
  end
  object pnlLegendas: TPanel [4]
    Left = 0
    Top = 331
    Width = 792
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 2
    object shpCor: TShape
      Left = 2
      Top = 4
      Width = 12
      Height = 12
      Brush.Color = clAqua
    end
    object lblCor: TLabel
      Left = 17
      Top = 3
      Width = 191
      Height = 15
      Alignment = taRightJustify
      Caption = 'Item sem estoque e ser'#225' cortado.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpMlt: TShape
      Left = 211
      Top = 4
      Width = 12
      Height = 12
      Brush.Color = 4227327
    end
    object lblMlt: TLabel
      Left = 226
      Top = 3
      Width = 221
      Height = 15
      Alignment = taRightJustify
      Caption = 'Item com m'#250'ltiplo de venda divergente.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object shpLiberado: TShape
      Left = 450
      Top = 4
      Width = 12
      Height = 12
      Brush.Color = clLime
    end
    object Label5: TLabel
      Left = 466
      Top = 3
      Width = 203
      Height = 15
      Alignment = taRightJustify
      Caption = 'Item sem estoque retirado do corte.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 312
    Top = 200
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 352
    Top = 200
    object cdsItensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 80
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,###0.000'
    end
    object cdsItensSALDOS: TFloatField
      FieldName = 'SALDOS'
      DisplayFormat = '#,###0.000'
    end
    object cdsItensAUTINC: TIntegerField
      FieldName = 'AUTINC'
    end
    object cdsItensTEMSALDOS: TBooleanField
      FieldName = 'TEMSALDOS'
    end
    object cdsItensCODUNI: TStringField
      FieldName = 'CODUNI'
      Size = 5
    end
    object cdsItensTIPO_FALTA: TStringField
      FieldName = 'TIPO_FALTA'
      Size = 1
    end
    object cdsItensUNITAR: TFloatField
      FieldName = 'UNITAR'
    end
    object cdsItensTOTITE: TFloatField
      FieldName = 'TOTITE'
    end
    object cdsItensCORMTL: TStringField
      FieldName = 'CORMTL'
      Size = 3
    end
    object cdsItensMLTITE: TFloatField
      FieldName = 'MLTITE'
    end
    object cdsItensUNIORI: TFloatField
      FieldName = 'UNIORI'
    end
    object cdsItensLIBERADO: TBooleanField
      FieldName = 'LIBERADO'
    end
    object cdsItensNUMCMP: TStringField
      FieldName = 'NUMCMP'
      Size = 15
    end
  end
end
