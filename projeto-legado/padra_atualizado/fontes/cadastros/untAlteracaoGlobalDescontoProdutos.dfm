inherited frmAlteracaoGlobalDescontoProdutos: TfrmAlteracaoGlobalDescontoProdutos
  Width = 395
  Height = 121
  Caption = 'Altera'#231#227'o de Valor de Desconto de Produtos'
  ExplicitWidth = 395
  ExplicitHeight = 121
  PixelsPerInch = 96
  TextHeight = 14
  object lblQuantidade: TLabel [0]
    Left = 5
    Top = 16
    Width = 118
    Height = 14
    Alignment = taRightJustify
    Caption = 'Percentual de Desconto:'
  end
  inherited pnlBotoes: TPanel
    Top = 48
    Width = 389
    TabOrder = 1
    inherited FlwBotoes: TFlowPanel
      Width = 385
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
      Left = 309
    end
  end
  inherited pnlStatus: TPanel
    Top = 76
    Width = 389
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 218
    end
    inherited pnlInfo: TPanel
      Width = 218
    end
  end
  object edtPercentualDesconto: TEditFocus [3]
    Tag = 99
    Left = 129
    Top = 12
    Width = 71
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 240
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 56
    Top = 80
  end
end
