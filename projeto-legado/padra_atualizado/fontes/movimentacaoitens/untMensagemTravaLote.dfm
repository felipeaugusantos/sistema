inherited frmMensagemTravaLote: TfrmMensagemTravaLote
  Width = 651
  Height = 217
  Caption = 'Trava de Lote'
  ExplicitWidth = 651
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 145
    Width = 645
    inherited btnSair: TBitBtnLocked
      Left = 562
      Caption = 'S&air'
    end
  end
  inherited pnlStatus: TPanel
    Top = 173
    Width = 645
    inherited pnlNomeForm: TPanel
      Left = 474
    end
    inherited pnlInfo: TPanel
      Width = 474
    end
  end
  object mmoMensagem: TMemoFocus [3]
    Left = 0
    Top = 0
    Width = 645
    Height = 145
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      ''
      
        '    Esse item j'#225' foi incluido em uma Entrada de Mercadorias que ' +
        'est'#225' em andamento '
      
        '    ou seu lotes est'#227'o sendo cadastrados no Cadastro de Lote, ne' +
        'sse momento, em outra esta'#231#227'o.'
      ''
      
        '    Caso o item esteja em uma Entrada de Mercadorias que ainda n' +
        #227'o finalizada, ser'#225' necess'#225'rio excluir o item da'
      
        '    entrada de mercadorias, cadastrar o lote e incluir o item no' +
        'vamente.    '
      '')
    ParentFont = False
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
    Texto = 
      '<<csq>><<csq>>    Esse item j'#225' foi incluido em uma Entrada de Me' +
      'rcadorias que est'#225' em andamento <<csq>>    ou seu lotes est'#227'o se' +
      'ndo cadastrados no Cadastro de Lote, nesse momento, em outra est' +
      'a'#231#227'o.<<csq>><<csq>>    Caso o item esteja em uma Entrada de Merc' +
      'adorias que ainda n'#227'o finalizada, ser'#225' necess'#225'rio excluir o item' +
      ' da<<csq>>    entrada de mercadorias, cadastrar o lote e incluir' +
      ' o item novamente.    <<csq>><<csq>>'
    ExplicitLeft = 224
    ExplicitTop = 32
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 712
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 616
    Top = 208
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 208
  end
end
