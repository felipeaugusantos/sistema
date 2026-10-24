inherited frmCadSalBalanco: TfrmCadSalBalanco
  Left = 342
  Top = 0
  Width = 530
  Height = 619
  BorderIcons = [biSystemMenu]
  Caption = 'Digita'#231#227'o de Saldo de Balan'#231'o'
  Position = poScreenCenter
  ExplicitWidth = 530
  ExplicitHeight = 619
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 574
    Width = 524
    TabOrder = 4
    ExplicitTop = 574
    ExplicitWidth = 524
    inherited FlwBotoes: TFlowPanel
      Width = 520
      ExplicitWidth = 520
    end
    inherited btnSair: TBitBtnLocked
      Left = 403
      ExplicitLeft = 403
    end
  end
  inherited pnlStatus: TPanel
    Top = 574
    Width = 524
    TabOrder = 3
    ExplicitTop = 574
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 339
      Width = 185
      ExplicitLeft = 339
      ExplicitWidth = 185
    end
    inherited pnlInfo: TPanel
      Width = 339
      ExplicitWidth = 339
    end
  end
  inherited pgcDados: TPageControl
    Top = 170
    Width = 524
    Height = 404
    TabOrder = 2
    ExplicitTop = 170
    ExplicitWidth = 524
    ExplicitHeight = 404
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 516
      ExplicitHeight = 372
    end
  end
  object pnlProduto: TPanel [3]
    Left = 0
    Top = 0
    Width = 524
    Height = 170
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label2: TLabel
      Left = 4
      Top = 9
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo Produto:'
    end
    object Label5: TLabel
      Left = 28
      Top = 55
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label7: TLabel
      Left = 24
      Top = 78
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label9: TLabel
      Left = 375
      Top = 78
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label11: TLabel
      Left = 47
      Top = 101
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label13: TLabel
      Left = 21
      Top = 124
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 12
      Top = 32
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object lblDtaIni: TLabel
      Left = 188
      Top = 9
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Balan'#231'o:'
    end
    object lblSldMlA: TLabel
      Left = 183
      Top = 147
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo ML/GR Atual:'
      Visible = False
    end
    object Label4: TLabel
      Left = 23
      Top = 147
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Saldo Atual:'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 82
      Top = 5
      Width = 77
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 0
      OnEnter = edtCodIteEnter
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtLinGru: TEditFocus
      Left = 82
      Top = 28
      Width = 386
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtDesIte: TEditFocus
      Left = 82
      Top = 51
      Width = 386
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 82
      Top = 74
      Width = 275
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 82
      Top = 97
      Width = 386
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 82
      Top = 120
      Width = 386
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesUni: TEditFocus
      Left = 420
      Top = 74
      Width = 48
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 259
      Top = 5
      Width = 77
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtSldMlA: TEditFocus
      Tag = 99
      Left = 278
      Top = 143
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 9
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.0000'
    end
    object edtSldAtu: TEditFocus
      Tag = 99
      Left = 82
      Top = 143
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,####0.0000'
    end
  end
  object pnlValor: TPanel [4]
    Left = 0
    Top = 170
    Width = 524
    Height = 404
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object pnlSaldos: TPanel
      Left = 1
      Top = 1
      Width = 522
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object lblSldBal: TLabel
        Left = 7
        Top = 8
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo Balan'#231'o:'
      end
      object lblSldMl: TLabel
        Left = 192
        Top = 8
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = 'Saldo em ML/GR:'
        Visible = False
      end
      object edtSldBal: TEditFocus
        Tag = 99
        Left = 81
        Top = 4
        Width = 77
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,###0.000'
      end
      object edtSldMl: TEditFocus
        Tag = 99
        Left = 277
        Top = 4
        Width = 77
        Height = 22
        Alignment = taRightJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,###0.000'
      end
    end
    object pnlSalLot: TPanel
      Left = 1
      Top = 31
      Width = 522
      Height = 372
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Grid de Lotes'
      ParentBackground = False
      ParentColor = True
      TabOrder = 1
      Visible = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 8
  end
end
