inherited frmTipoImobilizado: TfrmTipoImobilizado
  Width = 559
  Height = 632
  Caption = 'Tipo de Imobilizado/Patrim'#244'nio'
  ExplicitWidth = 559
  ExplicitHeight = 632
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 559
    Width = 553
    ExplicitTop = 559
    ExplicitWidth = 553
    inherited FlwBotoes: TFlowPanel
      Width = 549
      ExplicitWidth = 549
    end
    inherited btnSair: TBitBtnLocked
      Left = 472
      Height = 20
      ExplicitLeft = 472
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 587
    Width = 553
    ExplicitTop = 587
    ExplicitWidth = 553
    inherited pnlNomeForm: TPanel
      Left = 206
      ExplicitLeft = 206
    end
    inherited pnlInfo: TPanel
      Width = 206
      ExplicitWidth = 206
    end
  end
  inherited pgcDados: TPageControl
    Width = 553
    Height = 559
    ExplicitWidth = 553
    ExplicitHeight = 559
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 545
      ExplicitHeight = 527
    end
  end
  object pnlContainer: TPanel [3]
    Left = 0
    Top = 0
    Width = 553
    Height = 559
    Align = alClient
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 4
      Top = 12
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 81
      Top = 13
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object lblTaxDep: TLabel
      Left = 4
      Top = 54
      Width = 130
      Height = 14
      Caption = 'Taxa de deprecia'#231#227'o anual'
    end
    object dbeCodTip: TDBEditFocus
      Tag = 99
      Left = 4
      Top = 28
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TIP_CODTIP'
      DataSource = dtsDados
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 81
      Top = 28
      Width = 467
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TIP_DESCRI'
      DataSource = dtsDados
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeAlqDep: TDBEditFocus
      Tag = 99
      Left = 4
      Top = 71
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TIP_ALQDEP'
      DataSource = dtsDados
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object gbAtivoImobilizado: TGroupBox
      Left = 4
      Top = 97
      Width = 545
      Height = 46
      Caption = 'Ativo Imobilizado'
      TabOrder = 3
      object dbePCATIM: TDBEditFocus
        Tag = 99
        Left = 5
        Top = 18
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TIP_PCATIM'
        DataSource = dtsDados
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 0
        OnExit = dbePCATIMExit
        OnKeyPress = dbePCATIMKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtPCATIM: TEditFocus
        Left = 131
        Top = 18
        Width = 409
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
    end
    object gbFiscal: TGroupBox
      Left = 4
      Top = 146
      Width = 545
      Height = 152
      Caption = 'Fiscal'
      TabOrder = 4
      object Label3: TLabel
        Left = 5
        Top = 17
        Width = 147
        Height = 14
        Caption = 'Vida '#218'til - Deprecia'#231#227'o (Anos)'
      end
      object dbeVDUTFI: TDBEditFocus
        Tag = 99
        Left = 5
        Top = 34
        Width = 43
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TIP_VDUTFI'
        DataSource = dtsDados
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object GroupBox1: TGroupBox
        Left = 2
        Top = 57
        Width = 540
        Height = 44
        Caption = 'Deprecia'#231#227'o Acumulada'
        TabOrder = 1
        object edtPCDAFI: TEditFocus
          Left = 127
          Top = 17
          Width = 411
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbePCDAFI: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 17
          Width = 119
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TIP_PCDAFI'
          DataSource = dtsDados
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 1
          OnExit = dbePCDAFIExit
          OnKeyPress = dbePCDAFIKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object GroupBox2: TGroupBox
        Left = 2
        Top = 103
        Width = 540
        Height = 44
        Caption = 'Despesa com Deprecia'#231#227'o'
        TabOrder = 2
        object edtPCDDFI: TEditFocus
          Left = 127
          Top = 17
          Width = 411
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbePCDDFI: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 17
          Width = 119
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TIP_PCDDFI'
          DataSource = dtsDados
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 1
          OnExit = dbePCDDFIExit
          OnKeyPress = dbePCDDFIKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object gbSocietaria: TGroupBox
      Left = 4
      Top = 302
      Width = 545
      Height = 152
      Caption = 'Societ'#225'ria'
      TabOrder = 5
      object Label4: TLabel
        Left = 5
        Top = 17
        Width = 147
        Height = 14
        Caption = 'Vida '#218'til - Deprecia'#231#227'o (Anos)'
      end
      object dbeVDUTSO: TDBEditFocus
        Tag = 99
        Left = 5
        Top = 34
        Width = 43
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TIP_VDUTSO'
        DataSource = dtsDados
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object GroupBox4: TGroupBox
        Left = 2
        Top = 57
        Width = 540
        Height = 44
        Caption = 'Deprecia'#231#227'o Acumulada'
        TabOrder = 1
        object edtPCDASO: TEditFocus
          Left = 127
          Top = 17
          Width = 411
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbePCDASO: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 17
          Width = 119
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TIP_PCDASO'
          DataSource = dtsDados
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 1
          OnExit = dbePCDASOExit
          OnKeyPress = dbePCDASOKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object GroupBox5: TGroupBox
        Left = 2
        Top = 103
        Width = 540
        Height = 44
        Caption = 'Despesa com Deprecia'#231#227'o'
        TabOrder = 2
        object edtPCDDSO: TEditFocus
          Left = 127
          Top = 17
          Width = 411
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object dbePCDDSO: TDBEditFocus
          Tag = 99
          Left = 3
          Top = 17
          Width = 119
          Height = 22
          CharCase = ecUpperCase
          DataField = 'TIP_PCDDSO'
          DataSource = dtsDados
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 1
          OnExit = dbePCDDSOExit
          OnKeyPress = dbePCDDSOKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object gbCorrecaoMonetaria: TGroupBox
      Left = 4
      Top = 457
      Width = 545
      Height = 46
      Caption = 'Corre'#231#227'o Monet'#225'ria'
      TabOrder = 6
      object dbePCCRMN: TDBEditFocus
        Tag = 99
        Left = 4
        Top = 18
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TIP_PCCRMN'
        DataSource = dtsDados
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 0
        OnExit = dbePCCRMNExit
        OnKeyPress = dbePCCRMNKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtPCCRMN: TEditFocus
        Left = 131
        Top = 18
        Width = 409
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
    end
    object gbAvaliacao: TGroupBox
      Left = 4
      Top = 506
      Width = 545
      Height = 46
      Caption = 'Ajuste Avalia'#231#227'o Patrimonial'
      TabOrder = 7
      object dbePCAJPT: TDBEditFocus
        Tag = 99
        Left = 4
        Top = 18
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        DataField = 'TIP_PCAJPT'
        DataSource = dtsDados
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 0
        OnExit = dbePCAJPTExit
        OnKeyPress = dbePCAJPTKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtPCAJPT: TEditFocus
        Left = 131
        Top = 18
        Width = 409
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
    end
  end
  object dtsDados: TDataSource
    Left = 284
    Top = 68
  end
end
