inherited frmGerImpFiscais: TfrmGerImpFiscais
  Left = 501
  Top = 307
  Width = 380
  Height = 408
  BorderIcons = [biSystemMenu]
  Caption = 'Gerenciador de Impressoras Fiscais'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 380
  ExplicitHeight = 408
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 89
    Width = 374
    Height = 274
    ExplicitTop = 89
    ExplicitWidth = 374
    ExplicitHeight = 274
    DesignSize = (
      374
      274)
    inherited btnSair: TBitBtnLocked
      Left = 286
      Top = 246
      ParentFont = False
      TabOrder = 10
      ExplicitLeft = 286
      ExplicitTop = 246
    end
    object btnLeiturax: TBitBtnLocked
      Left = 8
      Top = 8
      Width = 177
      Height = 44
      Caption = 'Leitura &X'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnLeituraxClick
    end
    object btnCanCupom: TBitBtnLocked
      Left = 189
      Top = 8
      Width = 177
      Height = 44
      Caption = '&Cancelar Cupom'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnCanCupomClick
    end
    object btnReducaoz: TBitBtnLocked
      Left = 8
      Top = 56
      Width = 177
      Height = 44
      Caption = 'Redu'#231#227'o &Z'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnReducaozClick
    end
    object btnLeiMemFis: TBitBtnLocked
      Left = 189
      Top = 56
      Width = 177
      Height = 44
      Caption = 'Leit. Mem. Fiscal'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnLeiMemFisClick
    end
    object btnFormasPagto: TBitBtnLocked
      Left = 8
      Top = 104
      Width = 177
      Height = 44
      Caption = 'Programa Formas Pagto'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnFormasPagtoClick
    end
    object btnParEcf: TBitBtnLocked
      Left = 189
      Top = 104
      Width = 177
      Height = 44
      Caption = 'Parametros do ECF'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnParEcfClick
    end
    object btnImpRed: TBitBtnLocked
      Left = 8
      Top = 152
      Width = 177
      Height = 44
      Caption = '&Importar Redu'#231#227'o Z'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = btnImpRedClick
    end
    object btnUltRdz: TBitBtnLocked
      Left = 189
      Top = 152
      Width = 177
      Height = 44
      Caption = 'Dados da '#218'ltima RDZ'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = btnUltRdzClick
    end
    object btnEspMFD: TBitBtnLocked
      Left = 9
      Top = 200
      Width = 177
      Height = 44
      Caption = 'Espelho MFD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = btnEspMFDClick
    end
    object btnArqMFD: TBitBtnLocked
      Left = 189
      Top = 200
      Width = 177
      Height = 44
      Caption = 'Arquivo MFD'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = btnArqMFDClick
    end
  end
  object pnlCentral: TPanel [2]
    Left = 0
    Top = 0
    Width = 374
    Height = 89
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 5
      Width = 100
      Height = 14
      Caption = 'Impressora Utilizada:'
    end
    object Label3: TLabel
      Left = 16
      Top = 44
      Width = 28
      Height = 14
      Caption = 'Porta:'
    end
    object edtCodIFi: TEditFocus
      Left = 16
      Top = 21
      Width = 57
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesIFi: TEditFocus
      Left = 80
      Top = 21
      Width = 281
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPorCom: TEditFocus
      Left = 16
      Top = 60
      Width = 81
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 363
    Width = 374
    ExplicitTop = 363
    ExplicitWidth = 374
    inherited pnlNomeForm: TPanel
      Left = 203
      ExplicitLeft = 203
    end
    inherited pnlInfo: TPanel
      Width = 203
      ExplicitWidth = 203
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 440
    Top = 65520
  end
end
