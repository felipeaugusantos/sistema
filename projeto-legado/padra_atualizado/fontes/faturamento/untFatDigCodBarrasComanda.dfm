inherited frmFatDigCodBarrasComanda: TfrmFatDigCodBarrasComanda
  Width = 368
  Height = 124
  Caption = 'Comanda'
  ExplicitWidth = 368
  ExplicitHeight = 124
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 53
    Width = 362
    TabOrder = 1
    ExplicitTop = 53
    ExplicitWidth = 362
    inherited FlwBotoes: TFlowPanel
      Width = 281
      ExplicitWidth = 358
      object btnGravarSemComanda: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 147
        Height = 22
        Caption = '&Gravar sem Comanda'
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
        TabOrder = 1
        OnClick = btnGravarSemComandaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 283
      Top = 2
      Align = alRight
      ExplicitLeft = 280
    end
  end
  object pnlCodBarComanda: TPanel [2]
    Left = 0
    Top = 0
    Width = 362
    Height = 53
    Align = alClient
    TabOrder = 0
    object lblCodBarComanda: TLabel
      Left = 8
      Top = 6
      Width = 202
      Height = 14
      Caption = 'Leitura / Digita'#231#227'o do c'#243'digo da Comanda:'
    end
    object edtCodBarComanda: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 344
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 13
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 79
    Width = 362
    TabOrder = 2
    ExplicitTop = 79
    ExplicitWidth = 362
    inherited pnlNomeForm: TPanel
      Left = 191
      ExplicitLeft = 191
    end
    inherited pnlInfo: TPanel
      Width = 191
      ExplicitWidth = 191
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 176
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 56
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 56
    Top = 136
  end
end
