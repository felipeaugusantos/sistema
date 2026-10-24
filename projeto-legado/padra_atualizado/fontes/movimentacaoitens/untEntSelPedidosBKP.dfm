inherited frmEntSelPedidos: TfrmEntSelPedidos
  Left = 197
  Top = 166
  Width = 800
  Height = 557
  ActiveControl = dbgPedidos
  BorderIcons = [biSystemMenu]
  Caption = 'Sele'#231#227'o de Pedidos'
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 435
    Width = 792
    inherited btnSair: TBitBtn
      Left = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 507
    Width = 792
    inherited pnlNomeForm: TPanel
      Left = 624
      Width = 168
    end
    inherited pnlInfo: TPanel
      Width = 624
    end
  end
  inherited pgcDados: TPageControl
    Top = 32
    Width = 792
    Height = 403
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 0
    Width = 792
    Height = 32
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = 'SELE'#199#195'O DE PEDIDOS'
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'charter'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object dbgPedidos: TDBGridCitel [4]
    Left = 0
    Top = 32
    Width = 792
    Height = 403
    Align = alClient
    DataSource = frmModuloSPR.dtsTemporaria
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgPedidosDrawColumnCell
    OnDblClick = dbgPedidosDblClick
    OnKeyDown = dbgPedidosKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'PCG_NUMPED'
        Title.Caption = 'Nro. Ped.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODEMP'
        Title.Caption = 'Emp.'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODFOR'
        Title.Caption = 'C'#243'd. Forn.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_NOMFOR'
        Title.Caption = 'Nome do Fornecedor'
        Width = 260
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAPED'
        Title.Caption = 'Dta. Pedido'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTITE'
        Title.Alignment = taCenter
        Title.Caption = 'Total Itens'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTSUB'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Sub.'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTIPI'
        Title.Alignment = taCenter
        Title.Caption = 'Total IPI'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTGER'
        Title.Alignment = taCenter
        Title.Caption = 'Total Geral'
        Width = 70
        Visible = True
      end>
  end
  object pnlDadosInformativos: TPanel [5]
    Left = 0
    Top = 435
    Width = 792
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    object Label6: TLabel
      Left = 6
      Top = 16
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedidos Selecionados:'
    end
    object Label21: TLabel
      Left = 652
      Top = 15
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label2: TLabel
      Left = 241
      Top = 16
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Itens:'
    end
    object Label4: TLabel
      Left = 525
      Top = 16
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total IPI:'
    end
    object Label1: TLabel
      Left = 386
      Top = 16
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Sub.:'
    end
    object edtPedSel: TEditFocus
      Left = 118
      Top = 8
      Width = 51
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taCenter
    end
    object edtTotIte: TEditFocus
      Left = 299
      Top = 8
      Width = 74
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
    object edtTotIpi: TEditFocus
      Left = 569
      Top = 8
      Width = 74
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
    object edtTotGer: TEditFocus
      Left = 711
      Top = 8
      Width = 74
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
    object edtTotSub: TEditFocus
      Left = 443
      Top = 8
      Width = 74
      Height = 22
      TabStop = False
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
  end
  object pnlBotoesSelecao: TPanel [6]
    Left = 0
    Top = 471
    Width = 792
    Height = 36
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 6
    object btnConfirma: TBitBtn
      Left = 7
      Top = 8
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairSelecao: TBitBtn
      Left = 674
      Top = 7
      Width = 111
      Height = 22
      Caption = '[ ESC ] Sair'
      TabOrder = 1
      OnClick = btnSairSelecaoClick
    end
  end
end
