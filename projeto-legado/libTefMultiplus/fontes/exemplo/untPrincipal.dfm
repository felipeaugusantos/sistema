object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Exemplo TEF Multiplus'
  ClientHeight = 655
  ClientWidth = 950
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 113
    Height = 13
    Caption = 'Path Conector Multiplus'
  end
  object Label2: TLabel
    Left = 8
    Top = 52
    Width = 67
    Height = 13
    Caption = 'CNPJ Parceiro'
  end
  object Label3: TLabel
    Left = 188
    Top = 52
    Width = 61
    Height = 13
    Caption = 'CNPJ Cliente'
  end
  object Label7: TLabel
    Left = 348
    Top = 72
    Width = 76
    Height = 13
    Caption = '[Vendas Falsas]'
  end
  object Label8: TLabel
    Left = 364
    Top = 9
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Label10: TLabel
    Left = 504
    Top = 8
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object gpbOperacao: TGroupBox
    Left = 8
    Top = 117
    Width = 533
    Height = 80
    Caption = 'Opera'#231#227'o'
    Enabled = False
    TabOrder = 6
    object Label4: TLabel
      Left = 8
      Top = 28
      Width = 40
      Height = 13
      Caption = 'Parcelas'
    end
    object Label5: TLabel
      Left = 72
      Top = 28
      Width = 33
      Height = 13
      Caption = 'Cupom'
    end
    object Label6: TLabel
      Left = 160
      Top = 28
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label9: TLabel
      Left = 241
      Top = 28
      Width = 47
      Height = 13
      Caption = 'Opera'#231#227'o'
    end
    object edtParcelas: TEdit
      Left = 8
      Top = 43
      Width = 49
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object edtCupom: TEdit
      Left = 72
      Top = 43
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '1234'
    end
    object edtValor: TEdit
      Left = 160
      Top = 43
      Width = 61
      Height = 21
      TabOrder = 2
      Text = '1000'
    end
    object btnOperacao: TButton
      Left = 400
      Top = 39
      Width = 113
      Height = 25
      Caption = 'Opera'#231#227'o via TCP'
      TabOrder = 3
      OnClick = btnOperacaoClick
    end
    object cmbOperacao: TComboBox
      Left = 241
      Top = 43
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = 'ADM'
      Items.Strings = (
        'ADM'
        'D'#233'bito'
        'Cr'#233'dito a Vista'
        'Confirmar Venda'
        'Desfazer '#218'ltima Venda Pendente'
        'Cancelamento'
        'Cr'#233'dito Parcelado Loja'
        'Cr'#233'dito Parcelado ADM'
        'Reimpress'#227'o'
        'Pagamento de Contas'
        'Consulta CDC'
        'Consulta Saldo D'#233'bito'
        'Consulta Saldo Cr'#233'dito'
        'Relat'#243'rios')
    end
  end
  object edtPathMultiplus: TEdit
    Left = 8
    Top = 24
    Width = 337
    Height = 21
    TabOrder = 0
    Text = 'C:\ConectorTEF.exe'
  end
  object edtCNPJParceiro: TEdit
    Left = 8
    Top = 68
    Width = 150
    Height = 21
    TabOrder = 3
    Text = '51212892000125'
  end
  object edtCNPJCliente: TEdit
    Left = 188
    Top = 68
    Width = 150
    Height = 21
    TabOrder = 4
    Text = '04858474000120'
  end
  object mmoLog: TMemo
    Left = 0
    Top = 216
    Width = 950
    Height = 439
    Align = alBottom
    TabOrder = 7
  end
  object edtHost: TEdit
    Left = 364
    Top = 25
    Width = 113
    Height = 21
    TabOrder = 1
    Text = '127.0.0.1'
  end
  object edtPorta: TEdit
    Left = 504
    Top = 24
    Width = 113
    Height = 21
    TabOrder = 2
    Text = '100'
  end
  object btnIniciarCfg: TButton
    Left = 504
    Top = 64
    Width = 113
    Height = 25
    Caption = 'Iniciar Configura'#231#245'es'
    TabOrder = 5
    OnClick = btnIniciarCfgClick
  end
end
