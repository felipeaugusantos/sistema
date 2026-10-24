inherited frmCancelaBaixaOrdProd: TfrmCancelaBaixaOrdProd
  Width = 563
  Height = 216
  BorderIcons = [biSystemMenu]
  Caption = 'Cancelamento de Baixa de Ordem de Produ'#231#227'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 563
  ExplicitHeight = 216
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 145
    Width = 557
    Height = 26
    TabOrder = 1
    ExplicitTop = 145
    ExplicitWidth = 557
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 478
      Height = 22
      ExplicitWidth = 478
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 75
        Height = 22
        Align = alLeft
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 480
      Top = 2
      Width = 75
      Align = alRight
      ExplicitLeft = 480
      ExplicitTop = 2
      ExplicitWidth = 75
    end
  end
  inherited pnlStatus: TPanel
    Top = 171
    Width = 557
    TabOrder = 2
    ExplicitTop = 171
    ExplicitWidth = 557
    inherited pnlNomeForm: TPanel
      Left = 386
      ExplicitLeft = 386
    end
    inherited pnlInfo: TPanel
      Width = 386
      ExplicitWidth = 386
    end
  end
  object pnlOrdPro: TPanel [2]
    Left = 0
    Top = 0
    Width = 557
    Height = 34
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label3: TLabel
      Left = 29
      Top = 10
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Ordem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtOrdPro: TEditFocus
      Tag = 99
      Left = 84
      Top = 6
      Width = 115
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtOrdProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttInteiro
    end
  end
  object pnlDadCli: TPanel [3]
    Left = 0
    Top = 34
    Width = 557
    Height = 105
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 3
    object Label2: TLabel
      Left = 39
      Top = 10
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object Label6: TLabel
      Left = 410
      Top = 9
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produzido:'
    end
    object Label1: TLabel
      Left = 22
      Top = 33
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conferente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 10
      Top = 56
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es:'
    end
    object edtCodIte: TEditFocus
      Left = 84
      Top = 6
      Width = 67
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtDesIte: TEditFocus
      Left = 152
      Top = 6
      Width = 252
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtProduzido: TEditFocus
      Left = 467
      Top = 6
      Width = 67
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtObs001: TEditFocus
      Left = 84
      Top = 52
      Width = 450
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtObs002: TEditFocus
      Left = 84
      Top = 75
      Width = 450
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
    object edtConfer: TEditFocus
      Left = 84
      Top = 29
      Width = 450
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
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
  end
end
