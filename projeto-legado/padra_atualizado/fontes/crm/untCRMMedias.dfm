inherited frmCrmMedias: TfrmCrmMedias
  Width = 723
  Height = 443
  Caption = 'M'#233'dias do clientes'
  Position = poMainFormCenter
  ExplicitWidth = 723
  ExplicitHeight = 443
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 370
    Width = 717
    ExplicitTop = 370
    ExplicitWidth = 717
    inherited FlwBotoes: TFlowPanel
      Width = 713
      ExplicitWidth = 713
    end
    inherited btnSair: TBitBtnLocked
      Left = 637
      ExplicitLeft = 637
    end
  end
  inherited pnlStatus: TPanel
    Top = 398
    Width = 717
    ExplicitTop = 398
    ExplicitWidth = 717
    inherited pnlNomeForm: TPanel
      Left = 546
      ExplicitLeft = 546
    end
    inherited pnlInfo: TPanel
      Width = 546
      ExplicitWidth = 546
    end
  end
  object pnlInfCliente: TPanel [2]
    Left = 0
    Top = 0
    Width = 717
    Height = 87
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Enabled = False
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    Visible = False
    object GroupBox1: TGroupBox
      Left = 7
      Top = 0
      Width = 707
      Height = 87
      Caption = 'Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label3: TLabel
        Left = 133
        Top = 27
        Width = 38
        Height = 14
        Caption = 'Nome :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 12
        Top = 27
        Width = 45
        Height = 14
        Caption = 'C'#243'digo :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 13
        Top = 57
        Width = 44
        Height = 14
        Caption = 'Cidade :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCliCpfCnpj: TLabel
        Left = 465
        Top = 27
        Width = 59
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CNPJ-CPF :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCliCod: TEditFocus
        Left = 61
        Top = 24
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16770261
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCliNom: TEditFocus
        Left = 175
        Top = 24
        Width = 284
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        NormalColor = 16770261
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCliCid: TEditFocus
        Left = 61
        Top = 54
        Width = 637
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16770261
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCliCpfCnpj: TEditFocus
        Left = 530
        Top = 24
        Width = 168
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16770261
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlInfRede: TPanel [3]
    Left = 0
    Top = 87
    Width = 717
    Height = 56
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Enabled = False
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    Visible = False
    object GroupBox2: TGroupBox
      Left = 7
      Top = 0
      Width = 707
      Height = 56
      Caption = 'Rede de lojas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label2: TLabel
        Left = 133
        Top = 27
        Width = 60
        Height = 14
        Caption = 'Descri'#231#227'o :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 12
        Top = 27
        Width = 45
        Height = 14
        Caption = 'C'#243'digo :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtRedCod: TEditFocus
        Left = 61
        Top = 24
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16770261
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtRedDes: TEditFocus
        Left = 199
        Top = 24
        Width = 499
        Height = 22
        Alignment = taLeftJustify
        BevelKind = bkTile
        BorderStyle = bsNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        NormalColor = 16770261
        FocusColor = 16770261
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 143
    Width = 717
    Height = 227
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Label4: TLabel
      Left = 156
      Top = 35
      Width = 237
      Height = 16
      Caption = 'Taxa de Convers'#227'o de OR em Venda:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 156
      Top = 63
      Width = 136
      Height = 16
      Caption = 'Ticket m'#233'dio mensal:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 156
      Top = 119
      Width = 198
      Height = 16
      Caption = 'M'#233'dia Vendas dos '#250'lt. 3 meses:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 156
      Top = 91
      Width = 118
      Height = 16
      Caption = 'Vendas neste m'#234's:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 156
      Top = 147
      Width = 207
      Height = 16
      Caption = '% M'#233'dia de Desconto neste m'#234's:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 156
      Top = 175
      Width = 244
      Height = 16
      Caption = '% M'#233'dia de Desconto dos '#250'lt. 3 meses:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTxConvOrPd: TLabel
      Left = 523
      Top = 35
      Width = 39
      Height = 16
      Alignment = taRightJustify
      Caption = '0,00 %'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTicketMedioMensal: TLabel
      Left = 517
      Top = 63
      Width = 45
      Height = 16
      Alignment = taRightJustify
      Caption = 'R$ 0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMediaVendaU3M: TLabel
      Left = 517
      Top = 119
      Width = 45
      Height = 16
      Alignment = taRightJustify
      Caption = 'R$ 0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVendasNesteMes: TLabel
      Left = 517
      Top = 91
      Width = 45
      Height = 16
      Alignment = taRightJustify
      Caption = 'R$ 0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMediaDescontoMes: TLabel
      Left = 523
      Top = 147
      Width = 39
      Height = 16
      Alignment = taRightJustify
      Caption = '0,00 %'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMediaDescontoU3M: TLabel
      Left = 523
      Top = 175
      Width = 39
      Height = 16
      Alignment = taRightJustify
      Caption = '0,00 %'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFiltroDias: TLabel
      Left = 156
      Top = 7
      Width = 316
      Height = 16
      Caption = 'Dias para C'#225'lculo da M'#233'dia - Cliente Consumidor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object spnFiltroDias: TcxSpinEdit
      Left = 520
      Top = 6
      ParentFont = False
      Properties.MaxValue = 999.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.OnEditValueChanged = spnFiltroDiasPropertiesEditValueChanged
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 14
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      TabOrder = 0
      Value = 90
      Width = 42
    end
  end
end
