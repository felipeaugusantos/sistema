inherited frmPedidoCompraItem: TfrmPedidoCompraItem
  Width = 1297
  Height = 242
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Complete as informa'#231#245'es do item'
  Position = poMainFormCenter
  ExplicitWidth = 1297
  ExplicitHeight = 242
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 170
    Width = 1291
    Visible = False
    ExplicitTop = 143
    ExplicitWidth = 1291
    inherited btnSair: TBitBtnLocked
      Left = 1208
      ExplicitLeft = 1208
    end
  end
  inherited pnlStatus: TPanel
    Top = 198
    Width = 1291
    ExplicitTop = 171
    ExplicitWidth = 1291
    inherited pnlNomeForm: TPanel
      Left = 1120
      ExplicitLeft = 1120
    end
    inherited pnlInfo: TPanel
      Width = 1120
      ExplicitWidth = 1120
    end
  end
  object pnlTotPed: TPanel [3]
    Left = 0
    Top = 143
    Width = 1291
    Height = 27
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitLeft = 8
    ExplicitTop = 140
    object Label13: TLabel
      Left = 1
      Top = 6
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'TOTAL DO PEDIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotIpi: TLabel
      Left = 526
      Top = 5
      Width = 16
      Height = 14
      Alignment = taRightJustify
      Caption = 'IPI:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 396
      Top = 6
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'ITENS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotGer: TLabel
      Left = 831
      Top = 6
      Width = 137
      Height = 14
      Alignment = taRightJustify
      Caption = 'SUBSTITUI'#199#195'O+IPI+ITENS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblLitragem: TLabel
      Left = 237
      Top = 6
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'LITROS/KILOS:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotSubRod: TLabel
      Left = 646
      Top = 6
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'SUBSTITUI'#199#195'O:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 115
      Top = 6
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'PESO:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbeTotIte: TDBEdit
      Left = 433
      Top = 2
      Width = 81
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTITE'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
    end
    object dbeTotSub: TDBEdit
      Left = 734
      Top = 2
      Width = 73
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTSUB'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
    end
    object dbeTotIpi: TDBEdit
      Left = 546
      Top = 1
      Width = 81
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTIPI'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
    end
    object dbeTotGer: TDBEdit
      Left = 971
      Top = 2
      Width = 85
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_TOTGER'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
    end
    object dbeTotLit: TDBEdit
      Left = 317
      Top = 2
      Width = 68
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_LITROS'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
    end
    object dbeTotPes: TDBEdit
      Left = 148
      Top = 2
      Width = 71
      Height = 22
      HelpType = htKeyword
      TabStop = False
      Color = 16768952
      DataField = 'TOT_PESOIT'
      DataSource = dtsItensPedido
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
    end
  end
  object dtsItensPedido: TDataSource
    Left = 1192
    Top = 186
  end
end
