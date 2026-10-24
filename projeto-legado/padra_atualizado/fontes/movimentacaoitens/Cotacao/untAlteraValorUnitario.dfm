inherited frmAlteraValorUnitario: TfrmAlteraValorUnitario
  Height = 374
  Caption = 'Valores da Cota'#231#227'o'
  ExplicitHeight = 374
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 303
    TabOrder = 2
    ExplicitTop = 206
    inherited FlwBotoes: TFlowPanel
      Width = 402
      ExplicitTop = 2
      ExplicitWidth = 402
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Align = alRight
      ExplicitLeft = 404
      ExplicitTop = 2
    end
  end
  object pnlFornecedor: TPanel [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 4
    object lblFornecedor: TLabel
      Left = 5
      Top = 13
      Width = 472
      Height = 14
      AutoSize = False
      Caption = 'Fornecedor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlPrecos: TPanel [3]
    Left = 0
    Top = 41
    Width = 483
    Height = 184
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 165
    object Label1: TLabel
      Left = 115
      Top = 24
      Width = 80
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Quantidade:'
    end
    object Label2: TLabel
      Left = 24
      Top = 47
      Width = 171
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Pre'#231'o de Compra (Valor unit'#225'rio):'
    end
    object Label3: TLabel
      Left = 115
      Top = 70
      Width = 80
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '% IPI:'
    end
    object Label4: TLabel
      Left = 115
      Top = 93
      Width = 80
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '% Substitui'#231#227'o:'
    end
    object Label5: TLabel
      Left = 5
      Top = 162
      Width = 190
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Pre'#231'o de Compra Total com Impostos:'
    end
    object Label6: TLabel
      Left = 24
      Top = 139
      Width = 171
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Pre'#231'o de Compra com Impostos:'
    end
    object Label7: TLabel
      Left = 115
      Top = 116
      Width = 80
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '% Frete:'
    end
    object dbeQtdIte: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 16
      Width = 121
      Height = 22
      TabStop = False
      DataField = 'QTDITE'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValUni: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 39
      Width = 121
      Height = 22
      DataField = 'VALUNI01'
      DataSource = dtsItens
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIPIENT: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 62
      Width = 121
      Height = 22
      DataField = 'IPIENT01'
      DataSource = dtsItens
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSubsti: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 85
      Width = 121
      Height = 22
      DataField = 'SUBSTI01'
      DataSource = dtsItens
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValTot: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 154
      Width = 121
      Height = 22
      TabStop = False
      DataField = 'VALTOT01'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUniTot: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 131
      Width = 121
      Height = 22
      TabStop = False
      DataField = 'UNITOT01'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeFreEnt: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 108
      Width = 121
      Height = 22
      DataField = 'SUBSTI01'
      DataSource = dtsItens
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlReforma: TPanel [4]
    Left = 0
    Top = 225
    Width = 483
    Height = 78
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object lblAlqCbs: TLabel
      Left = 115
      Top = 12
      Width = 80
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '% CBS:'
    end
    object lblAlqIbs: TLabel
      Left = 115
      Top = 35
      Width = 80
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '% IBS:'
    end
    object lblAlq_Is: TLabel
      Left = 115
      Top = 58
      Width = 80
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '% IS:'
    end
    object dbeAlqCbs: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 4
      Width = 121
      Height = 22
      DataField = 'ALQCBS01'
      DataSource = dtsItens
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAlqIbs: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 27
      Width = 121
      Height = 22
      DataField = 'ALQIBS01'
      DataSource = dtsItens
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAlq_Is: TDBEditFocus
      Tag = 99
      Left = 198
      Top = 50
      Width = 121
      Height = 22
      DataField = 'ALQ_IS01'
      DataSource = dtsItens
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 329
    TabOrder = 3
    ExplicitTop = 232
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 80
  end
  object dtsItens: TDataSource
    Left = 280
    Top = 9
  end
end
