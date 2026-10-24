inherited frmLogSaneamento: TfrmLogSaneamento
  Width = 965
  Height = 481
  Caption = 'Log de transmiss'#227'o - Api Saneamento - IMendes'
  Position = poMainFormCenter
  ExplicitWidth = 965
  ExplicitHeight = 481
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 408
    Width = 959
    ExplicitTop = 408
    ExplicitWidth = 894
    inherited FlwBotoes: TFlowPanel
      Width = 955
      ExplicitWidth = 890
      object btnCopiar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 250
        Height = 22
        Caption = '[F4] Copiar para '#225'rea de transfer'#234'ncia'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
          FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
          00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
          F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
          00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
          F033777777777337F73309999990FFF0033377777777FFF77333099999000000
          3333777777777777333333399033333333333337773333333333333903333333
          3333333773333333333333303333333333333337333333333333}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnCopiarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 876
      ExplicitLeft = 811
    end
  end
  inherited pnlStatus: TPanel
    Top = 436
    Width = 959
    ExplicitTop = 436
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 788
      ExplicitLeft = 723
    end
    inherited pnlInfo: TPanel
      Width = 788
      ExplicitWidth = 723
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 959
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 894
    object lblTitulo: TLabel
      AlignWithMargins = True
      Left = 15
      Top = 12
      Width = 61
      Height = 29
      Margins.Left = 15
      Margins.Top = 12
      Align = alLeft
      Caption = 'lblTitulo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 19
    end
  end
  object edtLog: TRichEdit [3]
    Left = 0
    Top = 41
    Width = 959
    Height = 367
    Align = alClient
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
    Zoom = 100
    ExplicitWidth = 894
  end
end
