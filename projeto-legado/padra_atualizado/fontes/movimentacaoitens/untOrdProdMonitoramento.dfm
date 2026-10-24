inherited frmOrdProdMonitoramento: TfrmOrdProdMonitoramento
  Width = 590
  Height = 303
  Hint = 'frmOPIndMonitoramento'
  Caption = 'Monitoramento de Processos de Produ'#231#227'o'
  ExplicitWidth = 590
  ExplicitHeight = 303
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 230
    Width = 584
    TabOrder = 3
    ExplicitTop = 230
    ExplicitWidth = 584
    DesignSize = (
      584
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 580
      ExplicitWidth = 580
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnManMon: TBitBtnLocked
        Left = 150
        Top = 0
        Width = 207
        Height = 22
        Caption = '[ F3 ] Manuten'#231#227'o de Monitoramento'
        Enabled = False
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnManMonClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 504
      Top = 2
      ExplicitLeft = 504
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 258
    Width = 584
    TabOrder = 4
    ExplicitTop = 258
    ExplicitWidth = 584
    inherited pnlNomeForm: TPanel
      Left = 413
      ExplicitLeft = 413
    end
    inherited pnlInfo: TPanel
      Width = 413
      ExplicitWidth = 413
    end
  end
  object pnlCodBar: TPanel [2]
    Left = 0
    Top = 0
    Width = 584
    Height = 49
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 22
      Width = 201
      Height = 14
      Caption = 'C'#243'digo de Barras da Ordem de Produ'#231#227'o:'
    end
    object edtCodBar: TEditFocus
      Tag = 99
      Left = 222
      Top = 17
      Width = 97
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      OnKeyPress = edtCodBarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
  end
  object pnlBaixa: TPanel [3]
    Left = 0
    Top = 117
    Width = 584
    Height = 113
    Align = alClient
    BevelOuter = bvLowered
    Enabled = False
    TabOrder = 2
    object Label5: TLabel
      Left = 25
      Top = 15
      Width = 49
      Height = 14
      Caption = 'Operador:'
    end
    object Label6: TLabel
      Left = 47
      Top = 40
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fase:'
    end
    object Label8: TLabel
      Left = 29
      Top = 65
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object edtSenOpe: TEditFocus
      Tag = 99
      Left = 80
      Top = 10
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomOpe: TEditFocus
      Left = 172
      Top = 10
      Width = 398
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbxFase: TComboBoxFocus
      Tag = 99
      Left = 80
      Top = 35
      Width = 490
      Height = 22
      Style = csDropDownList
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object cbxSituacao: TComboBoxFocus
      Tag = 99
      Left = 80
      Top = 60
      Width = 490
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 3
      Text = 'Iniciando'
      Items.Strings = (
        'Iniciando'
        'Finalizando')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object btnIncluirSubprod: TBitBtnLocked
      Left = 80
      Top = 82
      Width = 137
      Height = 22
      Caption = '[ F4 ] &Incluir subprodutos'
      Enabled = False
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnIncluirSubprodClick
    end
  end
  object pnlInfoPrdAca: TPanel [4]
    Left = 0
    Top = 49
    Width = 584
    Height = 68
    Align = alTop
    BevelOuter = bvLowered
    Enabled = False
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 10
      Width = 89
      Height = 14
      AutoSize = False
      Caption = 'Produto acabado:'
    end
    object Label7: TLabel
      Left = 17
      Top = 37
      Width = 81
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Refer'#234'ncia:'
    end
    object lblUnidade: TLabel
      Left = 240
      Top = 37
      Width = 42
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Unidade:'
    end
    object lblCodFab: TLabel
      Left = 328
      Top = 37
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'd. F'#225'brica:'
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 176
      Top = 6
      Width = 394
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Left = 103
      Top = 6
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtReferencia: TEditFocus
      Left = 103
      Top = 34
      Width = 130
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSigUni: TEditFocus
      Left = 287
      Top = 34
      Width = 32
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFabrica: TEditFocus
      Left = 407
      Top = 34
      Width = 163
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 491
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 723
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 604
    Top = 8
  end
end
