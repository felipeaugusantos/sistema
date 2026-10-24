inherited frmDigTintaAutomotivaStandox: TfrmDigTintaAutomotivaStandox
  Width = 438
  Height = 609
  Caption = 'Tinta de M'#225'quina -'
  ExplicitWidth = 438
  ExplicitHeight = 609
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 537
    Width = 432
    ExplicitTop = 455
    ExplicitWidth = 432
    inherited btnSair: TBitBtnLocked
      Left = 349
      ExplicitLeft = 349
    end
  end
  inherited pnlGeral: TPanel
    Width = 432
    Height = 537
    ExplicitWidth = 432
    ExplicitHeight = 455
    inherited pnlCabecalho: TPanel
      Width = 430
      ExplicitWidth = 430
    end
    inherited pnlAdicional: TPanel
      Width = 430
      Height = 73
      ExplicitWidth = 430
      ExplicitHeight = 73
      inherited lblAdicional: TLabel
        Top = 32
        Font.Height = -11
        ParentFont = False
        ExplicitTop = 32
      end
      inherited cmbListaAdicional: TComboBoxFocus
        Top = 48
        Width = 193
        ExplicitTop = 48
        ExplicitWidth = 193
      end
      object rdgPorcDil: TRadioGroup
        Left = 285
        Top = 29
        Width = 142
        Height = 41
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          '10%'
          '20%')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = rdgPorcDilClick
      end
      object pnlMsgPercDiluicao: TPanel
        Left = 6
        Top = 1
        Width = 411
        Height = 28
        BevelOuter = bvNone
        TabOrder = 2
        object Label7: TLabel
          Left = 0
          Top = 0
          Width = 411
          Height = 14
          Align = alBottom
          Caption = 
            'O percentual de dilui'#231#227'o sugerido pela ind'#250'stria '#233' de 10% para c' +
            'ores lisas '
          Color = 16770261
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 408
        end
        object Label8: TLabel
          Left = 0
          Top = 14
          Width = 411
          Height = 14
          Align = alBottom
          Caption = 'e 20% para cores met'#225'licas. '
          Color = 16770261
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 155
        end
      end
    end
    inherited pnlRodape: TPanel
      Top = 400
      Width = 430
      Height = 53
      ExplicitTop = 400
      ExplicitWidth = 430
      ExplicitHeight = 54
    end
    inherited pnlTrocaEmb: TPanel
      Width = 430
      ExplicitWidth = 430
    end
    inherited pnlConsEmb: TPanel
      Width = 430
      ExplicitWidth = 430
    end
    inherited pnlModoVenda: TPanel
      Width = 430
      ExplicitWidth = 430
      inherited rdgModoVenda: TRadioGroup
        Width = 428
        ExplicitWidth = 428
      end
    end
    inherited pnlObservacao: TPanel
      Top = 453
      Width = 430
      ExplicitTop = 371
      ExplicitWidth = 430
    end
  end
  inherited pnlStatus: TPanel
    Top = 565
    Width = 432
    ExplicitTop = 483
    ExplicitWidth = 432
    inherited pnlNomeForm: TPanel
      Left = 261
      ExplicitLeft = 261
    end
    inherited pnlInfo: TPanel
      Width = 261
      ExplicitWidth = 261
    end
  end
end
