inherited frmConsultaPagamentoPix: TfrmConsultaPagamentoPix
  Width = 530
  Height = 230
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta Pix - ID'
  Position = poScreenCenter
  ExplicitWidth = 530
  ExplicitHeight = 230
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 157
    Width = 524
    TabOrder = 1
    ExplicitTop = 157
    ExplicitWidth = 524
    inherited FlwBotoes: TFlowPanel
      Width = 520
      ExplicitWidth = 520
    end
    inherited btnSair: TBitBtnLocked
      Left = 444
      Top = 2
      Height = 23
      ExplicitLeft = 444
      ExplicitTop = 2
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 185
    Width = 524
    TabOrder = 2
    ExplicitTop = 185
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 353
      ExplicitLeft = 353
    end
    inherited pnlInfo: TPanel
      Width = 353
      ExplicitWidth = 353
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 524
    Height = 157
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblCelular: TLabel
      Left = 89
      Top = 68
      Width = 269
      Height = 14
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblIdentificacaoPix: TLabel
      Left = 13
      Top = 16
      Width = 151
      Height = 14
      Caption = 'Numero de Identifica'#231#227'o do Pix:'
    end
    object grpStatus: TGroupBox
      Left = 13
      Top = 41
      Width = 504
      Height = 112
      Caption = 'Status:'
      TabOrder = 0
      Visible = False
      object lblPixCitel: TLabel
        Left = 17
        Top = 25
        Width = 53
        Height = 16
        Caption = 'Pix Citel:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblPixCitelResult: TLabel
        Left = 76
        Top = 20
        Width = 38
        Height = 23
        Caption = 'N'#195'O'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial Black'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblStatus: TLabel
        Left = 17
        Top = 43
        Width = 42
        Height = 16
        Caption = 'Status:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblStatusResult: TLabel
        Left = 63
        Top = 43
        Width = 4
        Height = 16
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblDtaHora: TLabel
        Left = 17
        Top = 59
        Width = 62
        Height = 16
        Caption = 'Data/Hora:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblDtaHorResult: TLabel
        Left = 82
        Top = 59
        Width = 4
        Height = 16
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblGerRotina: TLabel
        Left = 17
        Top = 75
        Width = 110
        Height = 16
        Caption = 'Gerado pela rotina:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblGerRotinaResult: TLabel
        Left = 133
        Top = 75
        Width = 4
        Height = 16
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMeiPagamento: TLabel
        Left = 17
        Top = 91
        Width = 120
        Height = 16
        Caption = 'Meio de Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblMeiPagamentoResult: TLabel
        Left = 143
        Top = 91
        Width = 4
        Height = 16
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
    end
    object btnConsultar: TBitBtnLocked
      Left = 407
      Top = 13
      Width = 110
      Height = 23
      Caption = 'Consultar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000090000
        000E0000000F0000000F00000010000000100000001000000010000000100000
        00100000001000000010000000100000000F0000000A00000002845D50C1B780
        6EFFB67E6CFFB47C6AFFB47A69FFB27967FFB17765FFB07662FFAF7461FFAE73
        5FFFAD725EFFAD715DFFAC705CFFAC6F5BFF7B4F40C100000009BB8775FFFAF4
        F0FFF9F1EDFFF9F1ECFFF9F0ECFFF8F1EBFFF8F0EBFFF8F0EBFFF8F0EAFFF7F0
        EAFFF7F0EAFFF7EFEAFFF7EFEAFFF8EFEAFFB37B68FF0000000DBD8A79FFFBF6
        F3FFF7EFE8FFF9F2EEFFF9F2EEFFF9F2EEFFF9F2EEFFF9F2EDFFF9F2EDFFF7ED
        E7FFF6EDE7FFF7EDE7FFF6EDE7FFF9F1EBFFB67E6CFF0000000DC08F7EFFFCF9
        F6FFF8EFE9FFC19989FFC09989FFBF9787FFBF9686FFBE9585FFBD9484FFF7EF
        E9FFF7EEE9FFF7EEE8FFF7EEE8FFF9F2EFFFB98371FF0000000CC49382FFFDFA
        F9FFF8F0EBFFFAF4F0FFFAF4EFFFFAF3EFFFFAF4EFFFFAF4EFFFFAF3EFFFF7EF
        E9FFF7EFE9FFF8EFE9FFF7EFE9FFFAF5F1FFBB8776FF0000000BC69787FFFEFC
        FBFFF8F1ECFFC49F90FFC49E8FFFC49D8DFFC39C8CFFC29B8BFFC1998AFFF8F0
        EBFFF8F0EBFFF8F0EAFFF8EFEAFFFBF7F4FFBE8C7AFF00000009C89B8BFFFEFD
        FDFFF8F2EEFFF9F1EDFFF8F1EDFFF8F1EDFFF8F1EDFFF8F1EDFFF8F1EDFFF8F1
        ECFFF8F1ECFF4A62DAFF4860D9FFFCF9F7FFC1907FFF00000008CA9F8FFFFEFE
        FDFFF9F2EEFFFAF2EEFFFAF2EEFFF9F2EEFFF9F2EEFFF9F2EDFFF9F2EDFFF9F2
        EDFFF9F1EEFF526CDEFF506ADCFFFDFAF8FFC39483FF00000007CCA192FFFFFF
        FEFFFAF3F0FFF9F3F0FFF9F3EFFFFAF3F0FFFAF3F0FFF9F3EFFFFAF3EFFFF9F2
        EFFFF9F3EEFF5B76E1FF5974E0FFFDFBFAFFC69887FF00000006CDA394FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FEFFFFFFFEFFFFFFFEFFFFFFFEFFFFFFFEFFC99C8CFF00000005A08377BFD8B0
        A1FFD7B0A0FFD7B0A0FFD7AF9FFFD6AF9FFFD6AE9EFFD5AE9EFFD5AD9DFFD4AC
        9CFFD4AB9CFFD3AA9AFFD2A999FFD2A899FF9A7B70C000000003000000010000
        0002000000020000000300000003000000030000000300000003000000030000
        0003000000030000000300000003000000030000000200000001000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 1
      OnClick = btnConsultarClick
    end
  end
  object edtIdentificacaoPix: TEditFocus [3]
    Tag = 99
    Left = 170
    Top = 13
    Width = 231
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 12
    ReadOnly = True
    TabOrder = 3
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 12
    TipoTexto = ttAlfanumerico
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 840
    Top = 432
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 888
    Top = 496
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 768
    Top = 456
  end
end
