inherited frmDadosEtiqProducao: TfrmDadosEtiqProducao
  Height = 250
  ActiveControl = edtNomBas
  Caption = 'Informa'#231#245'es da Etiqueta de Produ'#231#227'o da Tinta'
  ExplicitHeight = 250
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 178
    ExplicitTop = 178
  end
  inherited pnlStatus: TPanel
    Top = 206
    ExplicitTop = 206
  end
  object TPanel [2]
    Left = 0
    Top = 0
    Width = 483
    Height = 178
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 13
      Top = 14
      Width = 73
      Height = 14
      Caption = 'Nome da Base:'
    end
    object Label2: TLabel
      Left = 13
      Top = 102
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
    end
    object Label3: TLabel
      Left = 13
      Top = 124
      Width = 24
      Height = 14
      Caption = 'Lote:'
    end
    object Label4: TLabel
      Left = 13
      Top = 146
      Width = 97
      Height = 14
      Caption = 'Data de Fabrica'#231#227'o:'
    end
    object Label5: TLabel
      Left = 13
      Top = 36
      Width = 63
      Height = 14
      Caption = 'Componente:'
    end
    object Label6: TLabel
      Left = 13
      Top = 58
      Width = 41
      Height = 14
      Caption = 'Redutor:'
    end
    object Label7: TLabel
      Left = 13
      Top = 80
      Width = 86
      Height = 14
      Caption = 'Conteudo Liquido:'
    end
    object edtNomBas: TEditFocus
      Left = 116
      Top = 11
      Width = 348
      Height = 22
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtCodigo: TEditFocus
      Left = 116
      Top = 99
      Width = 195
      Height = 22
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtLote: TEditFocus
      Left = 116
      Top = 121
      Width = 195
      Height = 22
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtFabric: TEditFocus
      Left = 116
      Top = 143
      Width = 195
      Height = 22
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtCompon: TEditFocus
      Left = 116
      Top = 33
      Width = 348
      Height = 22
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtRedutor: TEditFocus
      Left = 116
      Top = 55
      Width = 348
      Height = 22
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtConLiq: TEditFocus
      Left = 116
      Top = 77
      Width = 348
      Height = 22
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
  end
end
