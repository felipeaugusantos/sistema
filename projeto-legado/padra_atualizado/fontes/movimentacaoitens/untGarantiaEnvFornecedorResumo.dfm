inherited frmGarantiaEnvFornecedorResumo: TfrmGarantiaEnvFornecedorResumo
  Width = 666
  Height = 543
  Caption = 'Garantia - Itens para envio ao fornecedor'
  ExplicitWidth = 666
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 471
    Width = 660
    ExplicitTop = 471
    ExplicitWidth = 660
    inherited btnSair: TBitBtnLocked
      Left = 577
      ExplicitLeft = 577
    end
  end
  inherited pnlStatus: TPanel
    Top = 499
    Width = 660
    ExplicitTop = 499
    ExplicitWidth = 660
    inherited pnlNomeForm: TPanel
      Left = 489
      ExplicitLeft = 489
    end
    inherited pnlInfo: TPanel
      Width = 489
      ExplicitWidth = 489
    end
  end
  inherited grdInfo: TcxGrid
    Width = 660
    Height = 445
    ExplicitWidth = 660
    ExplicitHeight = 445
    inherited grdInfoDBTableView: TcxGridDBTableView
      object grdInfoCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 50
      end
      object grdInfoDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 277
      end
      object grdInfoREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 143
      end
      object grdInfoUNIDAD: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'UNIDAD'
        Width = 85
      end
      object grdInfoQTDREQ: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDREQ'
        Width = 80
      end
    end
  end
  object pnlTotais: TPanel [4]
    Left = 0
    Top = 445
    Width = 660
    Height = 26
    Align = alBottom
    TabOrder = 4
    ExplicitLeft = -1
    ExplicitTop = 442
    object pnlQtdTotal: TPanel
      Left = 480
      Top = 1
      Width = 179
      Height = 24
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 4
        Width = 85
        Height = 17
        Caption = 'Qtd. Total Itens:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtQtdTotal: TDBEditFocus
        Left = 103
        Top = 0
        Width = 76
        Height = 24
        TabStop = False
        Align = alRight
        Color = 16768952
        DataField = 'QTDTOT'
        DataSource = dsrInfo
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
        ExplicitLeft = 121
      end
    end
    object pnlQtdItens: TPanel
      Left = 272
      Top = 1
      Width = 208
      Height = 24
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 37
        Top = 4
        Width = 117
        Height = 14
        Caption = 'Qtd. Itens Diferentes:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtQtdItens: TDBEditFocus
        Left = 156
        Top = 0
        Width = 52
        Height = 24
        TabStop = False
        Align = alRight
        Color = 16768952
        DataField = 'QTDITE'
        DataSource = dsrInfo
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
        ExplicitLeft = 183
      end
    end
  end
  inherited dsrInfo: TDataSource
    DataSet = cdsItens
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'CODITE'
    Params = <>
    StoreDefs = True
    Left = 224
    Top = 360
    object cdsItensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 255
    end
    object cdsItensREFERE: TStringField
      FieldName = 'REFERE'
      Size = 255
    end
    object cdsItensUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 255
    end
    object cdsItensQTDREQ: TFloatField
      FieldName = 'QTDREQ'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensQTDTOT: TAggregateField
      Alignment = taCenter
      FieldName = 'QTDTOT'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(QTDREQ)'
    end
    object cdsItensQTDITE: TAggregateField
      Alignment = taCenter
      FieldName = 'QTDITE'
      Active = True
      DisplayName = ''
      Expression = 'COUNT(CODITE)'
    end
  end
end
