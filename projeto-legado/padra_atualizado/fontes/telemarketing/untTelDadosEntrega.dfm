inherited frmTelDadosEntrega: TfrmTelDadosEntrega
  Width = 498
  Height = 249
  BorderIcons = [biSystemMenu]
  Caption = 'Teleatendimento - Dados de entrega do cliente'
  Position = poOwnerFormCenter
  ExplicitWidth = 498
  ExplicitHeight = 249
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 177
    Width = 492
    ExplicitTop = 177
    ExplicitWidth = 492
    inherited btnSair: TBitBtnLocked
      Left = 409
      ExplicitLeft = 409
    end
  end
  inherited pnlStatus: TPanel
    Top = 205
    Width = 492
    ExplicitTop = 205
    ExplicitWidth = 492
    inherited pnlNomeForm: TPanel
      Left = 321
      ExplicitLeft = 321
    end
    inherited pnlInfo: TPanel
      Width = 321
      ExplicitWidth = 321
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 492
    Height = 48
    Align = alTop
    Color = 16770261
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 32
      Height = 14
      Caption = 'Cliente'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 8
      Top = 19
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 79
      Top = 19
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 48
    Width = 492
    Height = 129
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 4
      Width = 46
      Height = 14
      Caption = 'Endere'#231'o'
    end
    object Label3: TLabel
      Left = 8
      Top = 44
      Width = 29
      Height = 14
      Caption = 'Bairro'
    end
    object Label4: TLabel
      Left = 195
      Top = 44
      Width = 33
      Height = 14
      Caption = 'Cidade'
    end
    object Label5: TLabel
      Left = 6
      Top = 83
      Width = 33
      Height = 14
      Caption = 'Estado'
    end
    object Label6: TLabel
      Left = 58
      Top = 83
      Width = 19
      Height = 14
      Caption = 'CEP'
    end
    object Label7: TLabel
      Left = 194
      Top = 83
      Width = 41
      Height = 14
      Caption = 'Telefone'
    end
    object Label8: TLabel
      Left = 298
      Top = 83
      Width = 37
      Height = 14
      Caption = 'Contato'
    end
    object edtEndEnt: TEditFocus
      Left = 7
      Top = 19
      Width = 474
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtBaiEnt: TEditFocus
      Left = 7
      Top = 59
      Width = 186
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCidEnt: TEditFocus
      Left = 194
      Top = 59
      Width = 286
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtEstEnt: TEditFocus
      Left = 6
      Top = 98
      Width = 51
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCepEnt: TEditFocus
      Left = 58
      Top = 98
      Width = 135
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTelEnt: TEditFocus
      Left = 194
      Top = 98
      Width = 103
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtConEnt: TEditFocus
      Left = 298
      Top = 98
      Width = 182
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
    end
