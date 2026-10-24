inherited frmCadCartoesBaixaOtimizada: TfrmCadCartoesBaixaOtimizada
  Width = 581
  Height = 549
  BorderIcons = []
  Caption = 'Adicionar/Alterar dados de baixa otimizada'
  ExplicitWidth = 581
  ExplicitHeight = 549
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 478
    Width = 575
    ExplicitTop = 478
    ExplicitWidth = 575
    inherited FlwBotoes: TFlowPanel
      Width = 571
      ExplicitWidth = 571
    end
    inherited btnSair: TBitBtnLocked
      Left = 495
      ExplicitLeft = 495
    end
  end
  inherited pnlStatus: TPanel
    Top = 504
    Width = 575
    ExplicitTop = 504
    ExplicitWidth = 575
    inherited pnlNomeForm: TPanel
      Left = 396
      Width = 179
      ExplicitLeft = 396
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 396
      ExplicitWidth = 396
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 575
    Height = 478
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblEmpresa: TLabel
      Left = 142
      Top = 9
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object dbeCodEmpOtimizada: TDBEditFocus
      Tag = 99
      Left = 190
      Top = 6
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CON_CODEMP'
      DataSource = dtsConPor
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
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object edtDesEmpOtimizada: TEditFocus
      Left = 255
      Top = 6
      Width = 300
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
    inline fraDadosPorEmpresa: TfraDadosDeBaixaOtimizadaCartoes
      Left = 8
      Top = 28
      Width = 561
      Height = 437
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 28
      ExplicitHeight = 437
      inherited grpCreditoTaxa: TGroupBox
        inherited dbePorBai: TDBEditFocus
          DataField = 'CON_PORCRE'
          DataSource = dtsConPor
        end
        inherited dbePorTax: TDBEditFocus
          DataField = 'CON_PORTAX'
          DataSource = dtsConPor
        end
        inherited dbeForTax: TDBEditFocus
          DataField = 'CON_FORTAX'
          DataSource = dtsConPor
        end
        inherited dbeCtaTax: TDBEditFocus
          DataField = 'CON_CTATAX'
          DataSource = dtsConPor
        end
        inherited dbeCtaCar: TDBEditFocus
          DataField = 'CON_CTACRE'
          DataSource = dtsConPor
        end
        inherited dbeEventoBaixa: TDBEditFocus
          DataField = 'CON_EVECRE'
          DataSource = dtsConPor
        end
        inherited dbeEventoTaxaBaixa: TDBEditFocus
          DataField = 'CON_EVETAX'
          DataSource = dtsConPor
        end
      end
      inherited grpDebito: TGroupBox
        inherited dbePorBad: TDBEditFocus
          DataField = 'CON_PORDEB'
          DataSource = dtsConPor
        end
        inherited dbeCtaBad: TDBEditFocus
          DataField = 'CON_CTADEB'
          DataSource = dtsConPor
        end
        inherited dbeEveDeb: TDBEditFocus
          DataField = 'CON_EVEDEB'
          DataSource = dtsConPor
        end
      end
      inherited grpCancelamentos: TGroupBox
        inherited dbeCtaAju: TDBEditFocus
          DataField = 'CON_CTAAJU'
          DataSource = dtsConPor
        end
        inherited edtCtaAju: TEditFocus
          Width = 301
          ExplicitWidth = 301
        end
      end
      inherited grpAntecipacao: TGroupBox
        inherited dbeCtaAnt: TDBEditFocus
          DataField = 'CON_CTAANT'
          DataSource = dtsConPor
          OnKeyPress = fraDadosPorEmpresadbeCtaAntKeyPress
        end
        inherited edtCtaAnt: TEditFocus
          Width = 301
          ExplicitWidth = 301
        end
      end
      inherited grpFretes: TGroupBox
        inherited dbeCtaFrete: TDBEditFocus
          DataField = 'CON_CTAFRE'
          DataSource = dtsConPor
          OnKeyPress = fraDadosPorEmpresadbeCtaFreteKeyPress
        end
      end
      inherited grpCupons: TGroupBox
        inherited dbeCtaCup: TDBEditFocus
          DataField = 'CON_CTACUP'
          DataSource = dtsConPor
          OnKeyPress = fraDadosPorEmpresadbeCtaCupKeyPress
        end
      end
    end
  end
  object dtsConPor: TDataSource
    AutoEdit = False
    Left = 96
    Top = 16
  end
end
