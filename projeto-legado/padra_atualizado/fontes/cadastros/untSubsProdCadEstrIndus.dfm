inherited frmSubsProdCadEstrIndus: TfrmSubsProdCadEstrIndus
  Width = 558
  Height = 273
  Caption = 'Substituir o Produto Selecionado'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 558
  ExplicitHeight = 273
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 200
    Width = 552
    ExplicitTop = 200
    ExplicitWidth = 552
    DesignSize = (
      552
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 548
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 548
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 469
      ExplicitLeft = 469
    end
    object btnConfirma: TBitBtnLocked
      Left = 7
      Top = 3
      Width = 100
      Height = 22
      Caption = '[ F10 ] Substituir'
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 552
    Height = 200
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object grbProdSel: TGroupBox
      Left = 1
      Top = 1
      Width = 550
      Height = 90
      Align = alTop
      Caption = 'Produto Selecionado'
      TabOrder = 0
      object Label4: TLabel
        Left = 23
        Top = 21
        Width = 37
        Height = 14
        Caption = 'Produto'
      end
      object edtProSel: TEditFocus
        Left = 23
        Top = 35
        Width = 87
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesProSel: TEditFocus
        Left = 110
        Top = 35
        Width = 421
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object grbProdSubs: TGroupBox
      Left = 1
      Top = 91
      Width = 550
      Height = 108
      Align = alClient
      Caption = 'Produto para Substituir'
      TabOrder = 1
      object Label1: TLabel
        Left = 23
        Top = 20
        Width = 37
        Height = 14
        Caption = 'Produto'
      end
      object Label2: TLabel
        Left = 22
        Top = 59
        Width = 53
        Height = 14
        Caption = 'Refer'#234'ncia'
      end
      object Label3: TLabel
        Left = 434
        Top = 59
        Width = 39
        Height = 14
        Caption = 'Unidade'
      end
      object edtProSubRef: TEditFocus
        Left = 22
        Top = 74
        Width = 411
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        Enabled = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtProSubUni: TEditFocus
        Left = 434
        Top = 74
        Width = 97
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        Enabled = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtProSub: TEditFocus
        Tag = 99
        Left = 23
        Top = 34
        Width = 87
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 2
        OnKeyPress = edtProSubKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesProSub: TEditFocus
        Left = 110
        Top = 34
        Width = 421
        Height = 22
        Alignment = taLeftJustify
        Color = 16770261
        Enabled = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 228
    Width = 552
    ExplicitTop = 228
    ExplicitWidth = 552
    inherited pnlNomeForm: TPanel
      Left = 381
      ExplicitLeft = 381
    end
    inherited pnlInfo: TPanel
      Width = 381
      ExplicitWidth = 381
    end
  end
end
