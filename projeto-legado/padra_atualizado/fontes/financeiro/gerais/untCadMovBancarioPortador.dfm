inherited frmCadMovBancarioPortador: TfrmCadMovBancarioPortador
  Width = 529
  Height = 133
  BorderIcons = [biSystemMenu]
  Caption = 'Selecione um novo portador para a Movimenta'#231#227'o Banc'#225'ria'
  Position = poScreenCenter
  ExplicitWidth = 529
  ExplicitHeight = 133
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 60
    Width = 523
    ExplicitTop = 60
    ExplicitWidth = 523
    inherited FlwBotoes: TFlowPanel
      Width = 519
      ExplicitWidth = 519
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
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
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 440
      ExplicitLeft = 440
    end
  end
  inherited pnlStatus: TPanel
    Top = 88
    Width = 523
    ExplicitTop = 88
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 352
      ExplicitLeft = 352
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 523
    Height = 60
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblPortadorAtualDesc: TLabel
      Left = 9
      Top = 8
      Width = 71
      Height = 14
      Caption = 'Portador Atual:'
    end
    object lblPortadorAtual: TLabel
      Left = 83
      Top = 8
      Width = 3
      Height = 14
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    object lblNovoPortadorDesc: TLabel
      Left = 8
      Top = 31
      Width = 72
      Height = 14
      Caption = 'Novo Portador:'
    end
    object edtCodigoPortador: TEditFocus
      Tag = 99
      Left = 86
      Top = 28
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodigoPortadorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomePortador: TEditFocus
      Left = 152
      Top = 28
      Width = 333
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    end
  end
end
