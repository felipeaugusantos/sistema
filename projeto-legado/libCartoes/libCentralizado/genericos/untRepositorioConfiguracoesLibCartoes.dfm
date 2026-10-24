object dtmRepositorioConfiguracoesLibCartoes: TdtmRepositorioConfiguracoesLibCartoes
  OldCreateOrder = False
  Height = 150
  Width = 215
  object cxRepositorioCartoes: TcxEditRepository
    Left = 47
    Top = 16
    PixelsPerInch = 96
    object libCartoesrdgSimNao: TcxEditRepositoryRadioGroupItem
      Properties.Columns = 2
      Properties.DefaultCaption = 'Selecione a op'#231#227'o desejada'
      Properties.DefaultValue = 'N'
      Properties.Items = <
        item
          Caption = 'SIM'
          Value = 'S'
        end
        item
          Caption = 'N'#195'O'
          Value = 'N'
        end>
    end
    object libCartoesedtTextoSemCase: TcxEditRepositoryTextItem
    end
    object libCartoesedtSenha: TcxEditRepositoryTextItem
      Properties.EchoMode = eemPassword
      Properties.MaxLength = 25
      Properties.PasswordChar = '*'
    end
    object libCartoesedtToleranciaConciliacao: TcxEditRepositoryCurrencyItem
      Properties.DecimalPlaces = 6
      Properties.DisplayFormat = '#,##0.000000;(#,##0.000000)'
      Properties.EditFormat = '#,##0.000000'
      Properties.UseThousandSeparator = True
    end
    object libCartoesedtTexto_Tam20: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 20
      Properties.ValidateOnEnter = True
      Properties.OnValidate = libCartoesedtTexto_Tam20PropertiesValidate
    end
    object libCartoesbtnCadEstabelecimentosCartoes: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecione os estabelecimentos'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object libCartoesedtTexto_Tam10: TcxEditRepositoryTextItem
      Properties.CharCase = ecUpperCase
      Properties.MaxLength = 10
      Properties.ValidateOnEnter = True
      Properties.OnValidate = libCartoesedtTexto_Tam20PropertiesValidate
    end
    object libCartoesedtValorInteiro: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.DisplayFormat = True
      Properties.DecimalPlaces = 0
    end
    object libCartoesrdgVersaoImpPagarMe: TcxEditRepositoryRadioGroupItem
      Properties.Items = <
        item
          Caption = 'v4 (Descontinuada)'
          Value = 'v4'
        end
        item
          Caption = 'v5'
          Value = 'v5'
        end
        item
          Caption = 'v5.1'
          Value = 'v5.1'
        end>
    end
    object libCartoesbtnCadIDRecebedorPagarMe: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecione os recebedores'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
    object libCartoesbtnCadChavesAutorizacaoPagarMe: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Caption = 'Selecione as chaves de autoriza'#231#227'o'
          Default = True
          Kind = bkText
        end>
      Properties.ReadOnly = True
      Properties.ViewStyle = vsButtonsAutoWidth
    end
  end
end
