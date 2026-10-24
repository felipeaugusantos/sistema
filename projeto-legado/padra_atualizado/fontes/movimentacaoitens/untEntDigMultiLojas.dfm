inherited frmEntDigMultiLojas: TfrmEntDigMultiLojas
  Left = 224
  Top = 207
  Width = 786
  Height = 422
  ActiveControl = dbgItens
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de Quantidades'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 351
    Width = 778
    object Label1: TLabel [0]
      Left = 96
      Top = 5
      Width = 187
      Height = 16
      Caption = '[F2] Giro de estoque anal'#237'tico'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    inherited btnSair: TBitBtn
      Left = 697
      TabOrder = 1
    end
    object btnConfirmaDados: TBitBtn
      Left = 4
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
      TabOrder = 0
      OnClick = btnConfirmaDadosClick
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
    end
  end
  inherited pnlStatus: TPanel
    Top = 379
    Width = 778
    inherited pnlNomeForm: TPanel
      Left = 607
    end
    inherited pnlInfo: TPanel
      Width = 607
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 778
    Height = 268
    Align = alClient
    DataSource = dtsPcdDet
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'PCD_EMPDES'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_DESEMP'
        ReadOnly = True
        Title.Caption = 'Emresa'
        Width = 203
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_MES001'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Mes 001'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_MES002'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Mes 001'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_MES003'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Mes 003'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_MEDIA_'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'M'#233'dia'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_SALDOS'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_SUGEST'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Sugest'#227'o'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCD_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 70
        Visible = True
      end>
  end
  object pnlTotais: TPanel [3]
    Left = 0
    Top = 268
    Width = 778
    Height = 83
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 3
    DesignSize = (
      778
      83)
    object lblTotal: TDBText
      Left = 670
      Top = 4
      Width = 97
      Height = 17
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      DataField = 'PCD_TOTAL_'
      DataSource = dtsPcdDet
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesTot: TLabel
      Left = 605
      Top = 4
      Width = 59
      Height = 19
      Anchors = [akTop, akRight]
      Caption = 'TOTAL:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQtdM04: TLabel
      Left = 8
      Top = 0
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM05: TLabel
      Left = 83
      Top = 0
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM06: TLabel
      Left = 158
      Top = 0
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM07: TLabel
      Left = 232
      Top = 0
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM08: TLabel
      Left = 7
      Top = 40
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM09: TLabel
      Left = 80
      Top = 41
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM10: TLabel
      Left = 155
      Top = 41
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM11: TLabel
      Left = 230
      Top = 41
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object lblQtdM12: TLabel
      Left = 304
      Top = 41
      Width = 47
      Height = 14
      Caption = 'lblQtdM04'
      Visible = False
    end
    object Label2: TLabel
      Left = 440
      Top = 0
      Width = 85
      Height = 14
      Caption = 'Maior venda: Qtd.'
    end
    object Label3: TLabel
      Left = 530
      Top = 0
      Width = 22
      Height = 14
      Caption = 'Data'
    end
    object Label4: TLabel
      Left = 373
      Top = 0
      Width = 62
      Height = 14
      Caption = 'Mult. Compra'
    end
    object dbeQtdM04: TDBEditFocus
      Left = 8
      Top = 14
      Width = 73
      Height = 22
      DataField = 'PCD_MES004'
      DataSource = dtsPcdDet
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
      Left = 83
      Top = 14
      Width = 73
      Height = 22
      DataField = 'PCD_MES005'
      DataSource = dtsPcdDet
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
      Left = 158
      Top = 14
      Width = 73
      Height = 22
      DataField = 'PCD_MES006'
      DataSource = dtsPcdDet
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
      Left = 232
      Top = 14
      Width = 73
      Height = 22
      DataField = 'PCD_MES007'
      DataSource = dtsPcdDet
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
      Left = 7
      Top = 54
      Width = 73
      Height = 22
      DataField = 'PCD_MES008'
      DataSource = dtsPcdDet
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
      Left = 80
      Top = 55
      Width = 73
      Height = 22
      DataField = 'PCD_MES009'
      DataSource = dtsPcdDet
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
      Left = 155
      Top = 55
      Width = 73
      Height = 22
      DataField = 'PCD_MES010'
      DataSource = dtsPcdDet
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
      Left = 230
      Top = 55
      Width = 73
      Height = 22
      DataField = 'PCD_MES011'
      DataSource = dtsPcdDet
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
      Left = 304
      Top = 55
      Width = 73
      Height = 22
      DataField = 'PCD_MES012'
      DataSource = dtsPcdDet
      TabOrder = 8
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMaQtSa: TDBEditFocus
      Left = 440
      Top = 14
      Width = 89
      Height = 22
      DataField = 'PCD_MAQTSA'
      DataSource = dtsPcdDet
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMaDtSa: TDBEditFocus
      Left = 530
      Top = 14
      Width = 71
      Height = 22
      DataField = 'PCD_MADTSA'
      DataSource = dtsPcdDet
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeMltCom: TDBEditFocus
      Left = 373
      Top = 14
      Width = 67
      Height = 22
      DataField = 'PCD_MLTCOM'
      DataSource = dtsPcdDet
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object dtsPcdDet: TDataSource
    DataSet = cdsPcdDet
    Left = 56
    Top = 96
  end
  object cdsPcdDet: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspPcdDet'
    Left = 112
    Top = 96
    object cdsPcdDetPCD_EMPDES: TStringField
      FieldName = 'PCD_EMPDES'
      Size = 3
    end
    object cdsPcdDetPCD_DESEMP: TStringField
      FieldName = 'PCD_DESEMP'
      Size = 50
    end
    object cdsPcdDetPCD_QTDITE: TFloatField
      FieldName = 'PCD_QTDITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES001: TFloatField
      FieldName = 'PCD_MES001'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES002: TFloatField
      FieldName = 'PCD_MES002'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES003: TFloatField
      FieldName = 'PCD_MES003'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES004: TFloatField
      FieldName = 'PCD_MES004'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES005: TFloatField
      FieldName = 'PCD_MES005'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES006: TFloatField
      FieldName = 'PCD_MES006'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES007: TFloatField
      FieldName = 'PCD_MES007'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES008: TFloatField
      FieldName = 'PCD_MES008'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES009: TFloatField
      FieldName = 'PCD_MES009'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES010: TFloatField
      FieldName = 'PCD_MES010'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES011: TFloatField
      FieldName = 'PCD_MES011'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MES012: TFloatField
      FieldName = 'PCD_MES012'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_SALDOS: TFloatField
      FieldName = 'PCD_SALDOS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,###0.000'
    end
    object cdsPcdDetPCD_MEDIA_: TFloatField
      FieldName = 'PCD_MEDIA_'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_SUGEST: TFloatField
      FieldName = 'PCD_SUGEST'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MAQTSA: TFloatField
      FieldName = 'PCD_MAQTSA'
      DisplayFormat = '#,##0.00'
    end
    object cdsPcdDetPCD_MADTSA: TDateField
      FieldName = 'PCD_MADTSA'
    end
    object cdsPcdDetPCD_MLTCOM: TIntegerField
      FieldName = 'PCD_MLTCOM'
    end
    object cdsPcdDetPCD_TOTAL_: TAggregateField
      DefaultExpression = '0'
      FieldName = 'PCD_TOTAL_'
      Active = True
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(PCD_QTDITE)'
    end
  end
end
