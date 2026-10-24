inherited frmExpDigVolumes: TfrmExpDigVolumes
  Left = 410
  Top = 406
  Width = 571
  Height = 175
  Caption = 'Expedi'#231#227'o'
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 571
  ExplicitHeight = 175
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 104
    Width = 565
    TabOrder = 1
    ExplicitTop = 94
    ExplicitWidth = 565
    inherited FlwBotoes: TFlowPanel
      Width = 561
      ExplicitWidth = 561
      inherited btnConfirma: TBitBtnLocked
        Width = 100
        Caption = '[F10] &Confirma'
        ExplicitWidth = 100
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 482
      ExplicitLeft = 482
    end
  end
  inherited pnlStatus: TPanel
    Top = 130
    Width = 565
    TabOrder = 2
    ExplicitTop = 120
    ExplicitWidth = 565
    inherited pnlNomeForm: TPanel
      Left = 440
      Width = 125
      ExplicitLeft = 440
      ExplicitWidth = 125
    end
    inherited pnlInfo: TPanel
      Width = 440
      ExplicitWidth = 440
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 565
    Height = 104
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 94
    object Label3: TLabel
      Left = 21
      Top = 16
      Width = 85
      Height = 14
      Caption = 'Qtde de Volumes:'
    end
    object lblPesBru: TLabel
      Left = 185
      Top = 16
      Width = 56
      Height = 14
      Caption = 'Peso Bruto:'
    end
    object lblPesLiq: TLabel
      Left = 369
      Top = 16
      Width = 64
      Height = 14
      Caption = 'Peso Liquido:'
    end
    object Label5: TLabel
      Left = 66
      Top = 42
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object chkEtiDes: TCheckBox
      Left = 245
      Top = 36
      Width = 171
      Height = 17
      Caption = 'Imprimir Etiquetas de Despacho'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object edtQtdVol: TEditFocus
      Tag = 99
      Left = 109
      Top = 9
      Width = 65
      Height = 27
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttInteiro
    end
    object edtPesBru: TEditFocus
      Tag = 99
      Left = 245
      Top = 9
      Width = 117
      Height = 27
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,###0.000'
    end
    object edtPesLiq: TEditFocus
      Tag = 99
      Left = 436
      Top = 9
      Width = 117
      Height = 27
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Text = '0'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,###0.000'
    end
    object edtEspTra: TEditFocus
      Tag = 99
      Left = 109
      Top = 37
      Width = 65
      Height = 27
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkEtiDesVolComp: TCheckBox
      Left = 245
      Top = 51
      Width = 292
      Height = 14
      Caption = 'Imprimir Etiquetas de Despacho de Volume Composto'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object pnlVolumeSepExc: TPanel
      Left = 0
      Top = 74
      Width = 565
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 6
      ExplicitTop = 64
      object lblQtdVolSepExc: TLabel
        Left = 11
        Top = 8
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vol. Sep. Exclusiva:'
      end
      object lblQtdVolSepNExc: TLabel
        Left = 189
        Top = 8
        Width = 117
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vol. Sep. N'#227'o Exclusiva:'
      end
      object edtQtdVolSepExc: TEditFocus
        Left = 109
        Top = 1
        Width = 65
        Height = 27
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 6
        TipoTexto = ttInteiro
      end
      object edtQtdVolSepNExc: TEditFocus
        Left = 309
        Top = 1
        Width = 65
        Height = 27
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        MaxLength = 6
        ParentFont = False
        TabOrder = 1
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 6
        TipoTexto = ttInteiro
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 552
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
  end
end
