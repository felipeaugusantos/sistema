inherited frmCadEfdContriSemDadosEscriturar: TfrmCadEfdContriSemDadosEscriturar
  Width = 593
  Height = 144
  Caption = 
    'Registro 0120 - Identifica'#231#227'o de EFD-Contribui'#231#245'es Sem Dados a E' +
    'scriturar'
  OnDestroy = FormDestroy
  ExplicitWidth = 593
  ExplicitHeight = 144
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 71
    Width = 587
    ExplicitTop = 71
    ExplicitWidth = 587
    inherited FlwBotoes: TFlowPanel
      Width = 583
      ExplicitTop = 2
      ExplicitWidth = 583
    end
  end
  inherited pnlStatus: TPanel
    Top = 99
    Width = 587
    ExplicitTop = 99
    ExplicitWidth = 587
    inherited pnlNomeForm: TPanel
      Left = 240
      ExplicitLeft = 240
    end
    inherited pnlInfo: TPanel
      Width = 240
      ExplicitWidth = 240
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 587
    Height = 71
    Align = alClient
    TabOrder = 3
    object lbl1: TLabel
      Left = 6
      Top = 5
      Width = 45
      Height = 14
      Caption = 'Cod. CST'
    end
    object lblTipo: TLabel
      Left = 72
      Top = 5
      Width = 67
      Height = 14
      Caption = 'Plano Cont'#225'bil'
    end
    object Label1: TLabel
      Left = 229
      Top = 5
      Width = 20
      Height = 14
      Caption = 'Tipo'
    end
  end
  inherited pgcDados: TPageControl
    Width = 587
    Height = 71
    ActivePage = nil
    ExplicitWidth = 587
    ExplicitHeight = 71
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 579
      ExplicitHeight = 61
    end
  end
  object pnlCentral: TPanel [4]
    Left = 0
    Top = 0
    Width = 587
    Height = 71
    Align = alClient
    Color = 16770261
    TabOrder = 4
    object Label2: TLabel
      Left = 14
      Top = 13
      Width = 43
      Height = 14
      Caption = 'M'#234's/Ano'
    end
    object Label3: TLabel
      Left = 80
      Top = 13
      Width = 183
      Height = 14
      Caption = 'Informa'#231#227'o Complementar do Registro'
    end
    object edtMesAno: TDBEditFocus
      Tag = 99
      Left = 13
      Top = 27
      Width = 61
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SDE_MESANO'
      DataSource = dtsEfdSde
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object cmbCodInf: TComboBoxFocus
      Tag = 99
      Left = 80
      Top = 27
      Width = 494
      Height = 22
      Style = csDropDownList
      Ctl3D = True
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Items.Strings = (
        '01 - Pessoa jur'#237'dica imune ou isenta do IRPJ'
        '02 - '#211'rg'#227'os p'#250'blicos, autarquias e funda'#231#245'es p'#250'blicas'
        '03 - Pessoa jur'#237'dica inativa'
        
          '04 - Pessoa jur'#237'dica em geral, que n'#227'o realizou opera'#231#245'es gerado' +
          'ras de receitas (tribut'#225'veis ou n'#227'o) ou de cr'#233'ditos'
        
          '05 - Sociedade em Conta de Participa'#231#227'o - SCP, que n'#227'o realizou ' +
          'opera'#231#245'es geradoras de receitas (tribut'#225'veis ou n'#227'o) ou de cr'#233'di' +
          'tos'
        
          '06 - Sociedade Cooperativa, que n'#227'o realizou opera'#231#245'es geradoras' +
          ' de receitas (tribut'#225'veis ou n'#227'o) ou de cr'#233'ditos'
        
          '07 - Escritura'#231#227'o decorrente de incorpora'#231#227'o, fus'#227'o ou cis'#227'o, se' +
          'm opera'#231#245'es geradoras de receitas (tribut'#225'veis ou n'#227'o) ou de cr'#233 +
          'ditos'
        
          '99 - Demais hip'#243'teses de dispensa de escritura'#231#227'o, relacionadas ' +
          'no art. 5'#186', da IN RFB n'#186' 1.252, de 2012')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 688
    Top = 48
  end
  object dtsEfdSde: TDataSource
    Left = 480
    Top = 4
  end
end
