inherited frmMsgPagtoAntecipado: TfrmMsgPagtoAntecipado
  Width = 638
  Height = 186
  Caption = 'Pagamento antecipado excede o valor da entrada'
  ExplicitWidth = 638
  ExplicitHeight = 186
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 114
    Width = 632
    inherited btnSair: TBitBtnLocked
      Left = 549
      Caption = 'Sair'
    end
  end
  inherited pnlStatus: TPanel
    Top = 142
    Width = 632
    inherited pnlNomeForm: TPanel
      Left = 461
    end
    inherited pnlInfo: TPanel
      Width = 461
    end
  end
  object MemoFocus1: TMemoFocus [3]
    Left = 0
    Top = 0
    Width = 632
    Height = 114
    Align = alClient
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      
        '                                                                ' +
        '                    Aten'#231#227'o'
      
        '               N'#227'o podemos utilizar como pagamento antecipado um' +
        ' valor de contas a pagar maior do que a'
      
        '      entrada atual, para assim evitarmos problemas com a integr' +
        'idade do contas a pagar original da antecipa'#231#227'o.'
      
        '      Para realizar a utiliza'#231#227'o deste pagamento antecipado, fav' +
        'or realizar a entrada de mercadoria'
      
        '            normal, lan'#231'ando o contas a pagar e posteriormente r' +
        'ealizando a baixa diretamente no '
      
        '                                                controle finance' +
        'iro com a utiliza'#231#227'o do cr'#233'dito.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
    Texto = 
      '<<csq>>                                                         ' +
      '                           Aten'#231#227'o<<csq>>               N'#227'o pode' +
      'mos utilizar como pagamento antecipado um valor de contas a paga' +
      'r maior do que a<<csq>>      entrada atual, para assim evitarmos' +
      ' problemas com a integridade do contas a pagar original da antec' +
      'ipa'#231#227'o.<<csq>>      Para realizar a utiliza'#231#227'o deste pagamento a' +
      'ntecipado, favor realizar a entrada de mercadoria<<csq>>        ' +
      '    normal, lan'#231'ando o contas a pagar e posteriormente realizand' +
      'o a baixa diretamente no <<csq>>                                ' +
      '                controle financeiro com a utiliza'#231#227'o do cr'#233'dito.' +
      '<<csq>>'
    ExplicitLeft = 176
    ExplicitTop = 64
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 656
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 576
    Top = 72
  end
end
