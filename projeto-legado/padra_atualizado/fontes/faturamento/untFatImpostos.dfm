inherited frmFatImpostos: TfrmFatImpostos
  Left = 482
  Top = 194
  Width = 1024
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 
    ' Visualiza'#231#227'o do Cliente, Itens e Dados Fiscais para Emiss'#227'o da ' +
    'Nota Fiscal'
  Position = poMainFormCenter
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 555
    Width = 1018
    TabOrder = 4
    ExplicitTop = 555
    ExplicitWidth = 1018
    inherited pnlInfo: TPanel [0]
      Width = 847
      ExplicitWidth = 847
    end
    inherited pnlNomeForm: TPanel [1]
      Left = 847
      ExplicitLeft = 847
    end
  end
  object pnlBusca: TPanel [1]
    Left = 0
    Top = 0
    Width = 1018
    Height = 90
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblCliente: TLabel
      Left = 36
      Top = 16
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object lblEndereco: TLabel
      Left = 22
      Top = 39
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
    end
    object Label2: TLabel
      Left = 485
      Top = 39
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label3: TLabel
      Left = 910
      Top = 39
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object Label4: TLabel
      Left = 19
      Top = 62
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade/UF:'
    end
    object Label6: TLabel
      Left = 682
      Top = 64
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Insc. Est./RG:'
    end
    object Label7: TLabel
      Left = 421
      Top = 64
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'CPF/CNPJ:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 73
      Top = 13
      Width = 75
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 5
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 149
      Top = 13
      Width = 857
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtEndereco: TEditFocus
      Left = 73
      Top = 36
      Width = 408
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtBairro: TEditFocus
      Left = 519
      Top = 36
      Width = 378
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCEP: TEditFocus
      Left = 936
      Top = 36
      Width = 70
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCidade: TEditFocus
      Left = 73
      Top = 59
      Width = 341
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCPF: TEditFocus
      Left = 473
      Top = 59
      Width = 190
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRG: TEditFocus
      Left = 747
      Top = 59
      Width = 259
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 90
    Width = 1018
    Height = 208
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 1
    object dbgItens: TDBGridCitel
      Left = 0
      Top = 0
      Width = 1018
      Height = 208
      Align = alClient
      DataSource = dtsVenda
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'ITE_CODITE'
          Title.Caption = 'C'#243'digo'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_DESSIM'
          Title.Caption = 'Descri'#231#227'o'
          Width = 329
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_CLAIPI'
          Title.Caption = 'NCM'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_CLAFIS'
          Title.Caption = 'CFOP'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ABF_CODSIT'
          Title.Caption = 'Sit.Trib.'
          Width = 40
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_TOTITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Tot. Item'
          Width = 53
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_BASICM'
          Title.Alignment = taRightJustify
          Title.Caption = 'B.C. ICMS'
          Width = 53
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_ALQICM'
          Title.Alignment = taRightJustify
          Title.Caption = 'Al'#237'. ICMS'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VALICM'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. ICMS'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_BASIPI'
          Title.Alignment = taRightJustify
          Title.Caption = 'B.C. IPI'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_ALQIPI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Al'#237'. IPI'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VALIPI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. IPI'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_BASRET'
          Title.Alignment = taRightJustify
          Title.Caption = 'B.C. ST'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VALRET'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. ST'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_VALCBS'
          Title.Caption = 'Vlr. CBS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_VALIBS'
          Title.Caption = 'Vlr. IBS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_VAL_IS'
          Title.Caption = 'Vlr. IS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_ICMORG'
          Title.Caption = 'Desonera'#231#227'o'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ITE_CSTPIS'
          Title.Caption = 'CST PIS'
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_BASPIS'
          Title.Alignment = taRightJustify
          Title.Caption = 'B.C. PIS'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_ALQPIS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Al'#237'. PIS'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VALPIS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. PIS'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_CSTCOF'
          Title.Caption = 'CST COF'
          Width = 50
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_BASCOF'
          Title.Alignment = taRightJustify
          Title.Caption = 'B.C. COF.'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_ALQCOF'
          Title.Alignment = taRightJustify
          Title.Caption = 'Al'#237'. COF.'
          Width = 54
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VALCOF'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. COF.'
          Width = 54
          Visible = True
        end>
    end
  end
  object pnlVendedor: TPanel [3]
    Left = 0
    Top = 298
    Width = 1018
    Height = 69
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label5: TLabel
      Left = 19
      Top = 15
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label8: TLabel
      Left = 15
      Top = 38
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label9: TLabel
      Left = 846
      Top = 38
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object lblClaIpi: TLabel
      Left = 863
      Top = 15
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'NCM:'
    end
    object edtDescricao: TEditFocus
      Left = 73
      Top = 12
      Width = 752
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtReferencia: TEditFocus
      Left = 73
      Top = 35
      Width = 752
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtUnidade: TEditFocus
      Left = 890
      Top = 35
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtClaIpi: TEditFocus
      Left = 890
      Top = 12
      Width = 116
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 367
    Width = 1018
    Height = 160
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    object Label10: TLabel
      Left = 18
      Top = 15
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total dos Produtos:'
    end
    object lbl2: TLabel
      Left = 35
      Top = 38
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total B.C. ICMS:'
    end
    object lbl3: TLabel
      Left = 49
      Top = 61
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total B.C. IPI:'
    end
    object lbl4: TLabel
      Left = 4
      Top = 84
      Width = 106
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total B.C. Subst. Trib.:'
    end
    object Label11: TLabel
      Left = 297
      Top = 15
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desc. Especial:'
    end
    object Label12: TLabel
      Left = 300
      Top = 38
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Vlr. ICMS:'
    end
    object Label13: TLabel
      Left = 314
      Top = 61
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Vlr. IPI:'
    end
    object Label14: TLabel
      Left = 269
      Top = 84
      Width = 102
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Vlr. Subst. Trib.:'
    end
    object Label15: TLabel
      Left = 827
      Top = 38
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vlr. Frete:'
    end
    object Label16: TLabel
      Left = 785
      Top = 61
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desp. Acess'#243'rias:'
    end
    object Label18: TLabel
      Left = 820
      Top = 84
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object Label1: TLabel
      Left = 821
      Top = 15
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vlr.FCP ST:'
    end
    object lblTotPis: TLabel
      Left = 306
      Top = 107
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Vlr. PIS.:'
    end
    object lblTbcPis: TLabel
      Left = 44
      Top = 107
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total B.C. PIS:'
    end
    object lblTotCof: TLabel
      Left = 287
      Top = 130
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Vlr. COFINS:'
    end
    object lblTbcCof: TLabel
      Left = 22
      Top = 130
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total B.C. COFINS:'
    end
    object lblTitIBS: TLabel
      Left = 574
      Top = 38
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total IBS:'
    end
    object lblTitIS: TLabel
      Left = 581
      Top = 61
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total IS:'
    end
    object lblTitVlrCBS: TLabel
      Left = 569
      Top = 15
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total CBS:'
    end
    object edtTotPro: TEditFocus
      Tag = 99
      Left = 112
      Top = 12
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTbcICM: TEditFocus
      Tag = 99
      Left = 112
      Top = 35
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTbcIPI: TEditFocus
      Tag = 99
      Left = 112
      Top = 58
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTbcRet: TEditFocus
      Tag = 99
      Left = 112
      Top = 81
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesEsp: TEditFocus
      Tag = 99
      Left = 373
      Top = 12
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotICM: TEditFocus
      Tag = 99
      Left = 373
      Top = 35
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotIPI: TEditFocus
      Tag = 99
      Left = 373
      Top = 58
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotRet: TEditFocus
      Tag = 99
      Left = 373
      Top = 81
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotFre: TEditFocus
      Tag = 99
      Left = 876
      Top = 35
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesAce: TEditFocus
      Tag = 99
      Left = 876
      Top = 58
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotGer: TEditFocus
      Tag = 99
      Left = 876
      Top = 81
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTbcFCP: TEditFocus
      Tag = 99
      Left = 876
      Top = 12
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotPis: TEditFocus
      Tag = 99
      Left = 373
      Top = 104
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTbcPis: TEditFocus
      Tag = 99
      Left = 112
      Top = 104
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotCof: TEditFocus
      Tag = 99
      Left = 373
      Top = 127
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTbcCof: TEditFocus
      Tag = 99
      Left = 112
      Top = 127
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotIBS: TEditFocus
      Tag = 99
      Left = 620
      Top = 35
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotIS: TEditFocus
      Tag = 99
      Left = 620
      Top = 58
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtTotCBS: TEditFocus
      Tag = 99
      Left = 620
      Top = 12
      Width = 130
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      MaxLength = 5
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  inherited pnlBotoes: TPanel [5]
    Top = 527
    Width = 1018
    TabOrder = 2
    ExplicitTop = 527
    ExplicitWidth = 1018
    DesignSize = (
      1018
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 937
      ExplicitLeft = 937
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 536
    Top = 160
  end
  object dtsVenda: TDataSource
    Left = 472
    Top = 160
  end
end
