inherited frmObservacaoCRM: TfrmObservacaoCRM
  Width = 1024
  Height = 600
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Observa'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 1018
    ExplicitTop = 527
    ExplicitWidth = 1018
    DesignSize = (
      1018
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 914
      Width = 100
      Caption = '[ ESC ] &Sair'
      TabOrder = 2
      ExplicitLeft = 914
      ExplicitWidth = 100
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 3
      Width = 75
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
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1018
    ExplicitTop = 555
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      Caption = 'Pressione < ESC> para sair...'
      ExplicitWidth = 847
    end
  end
  object pnlObs: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 491
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlObs'
    TabOrder = 3
    ExplicitLeft = 53
    ExplicitTop = 216
    ExplicitWidth = 812
    ExplicitHeight = 308
    DesignSize = (
      1018
      491)
    object lblMensagem: TLabel
      Left = 10
      Top = 16
      Width = 113
      Height = 14
      Caption = 'Digite uma observa'#231#227'o:'
    end
    object memObs: TMemoFocus
      Left = 10
      Top = 33
      Width = 996
      Height = 452
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnKeyDown = memObsKeyDown
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object pnlOperadorDestino: TPanel [4]
    Left = 0
    Top = 491
    Width = 1018
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      1018
      36)
    object lblOperadorDestino: TLabel
      Left = 10
      Top = 6
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador Destino:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 104
      Top = 3
      Width = 84
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesCodOpe: TEditFocus
      Left = 191
      Top = 3
      Width = 815
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 80
  end
end
