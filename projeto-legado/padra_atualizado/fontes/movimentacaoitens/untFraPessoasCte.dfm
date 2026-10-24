inherited FraPessoasCte: TFraPessoasCte
  Left = 0
  Top = 0
  Width = 912
  Height = 267
  Align = alClient
  BorderIcons = []
  BorderStyle = bsNone
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  ExplicitWidth = 912
  ExplicitHeight = 267
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 223
    Width = 912
    ExplicitTop = 223
    ExplicitWidth = 912
    inherited FlwBotoes: TFlowPanel
      Width = 908
      ExplicitWidth = 908
    end
    inherited btnSair: TBitBtnLocked
      Left = 780
      ExplicitLeft = 780
    end
  end
  inherited pnlStatus: TPanel
    Top = 251
    Width = 912
    ExplicitTop = 251
    ExplicitWidth = 912
    inherited pnlNomeForm: TPanel
      Left = 741
      ExplicitLeft = 741
    end
    inherited pnlInfo: TPanel
      Width = 741
      ExplicitWidth = 741
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 912
    Height = 223
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    ParentBackground = False
    TabOrder = 2
    object Panel2: TPanel
      Left = 5
      Top = 5
      Width = 902
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label13: TLabel
        Left = 11
        Top = 5
        Width = 96
        Height = 13
        Caption = 'Tipo de Documento:'
      end
      object Label7: TLabel
        Left = 301
        Top = 5
        Width = 46
        Height = 13
        Caption = 'Tomador:'
      end
      object cmbTipoDocumentoAnexoCTE: TComboBox
        Tag = 99
        Left = 108
        Top = 2
        Width = 179
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 0
        OnChange = cmbTipoDocumentoAnexoCTEChange
      end
      object cmbTomador: TComboBox
        Tag = 99
        Left = 348
        Top = 2
        Width = 145
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 1
        OnChange = cmbTomadorChange
        Items.Strings = (
          ''
          'Remetente'
          'Expedidor'
          'Recebedor'
          'Destinat'#225'rio'
          'Outros')
      end
    end
    object pgcPessoas: TPageControl
      Left = 5
      Top = 31
      Width = 902
      Height = 187
      ActivePage = tbsRemetente
      Align = alClient
      TabOrder = 1
      ExplicitTop = 32
      object tbsRemetente: TTabSheet
        Caption = 'Remetente'
        object pnlTopo: TPanel
          Left = 0
          Top = 0
          Width = 894
          Height = 159
          Align = alClient
          Padding.Left = 5
          Padding.Top = 5
          Padding.Right = 5
          Padding.Bottom = 5
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object grbRemetente: TGroupBox
            Left = 6
            Top = 6
            Width = 882
            Height = 106
            Align = alTop
            Caption = 'Remetente'
            Padding.Left = 10
            Padding.Right = 10
            TabOrder = 0
            object Label1: TLabel
              Left = 11
              Top = 18
              Width = 48
              Height = 13
              Caption = 'CNPJ/CPF'
            end
            object Label2: TLabel
              Left = 115
              Top = 18
              Width = 60
              Height = 13
              Caption = 'Raz'#227'o Social'
            end
            object Label3: TLabel
              Left = 644
              Top = 18
              Width = 87
              Height = 13
              Caption = 'Inscri'#231#227'o Estadual'
            end
            object Label4: TLabel
              Left = 11
              Top = 57
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object Label5: TLabel
              Left = 37
              Top = 57
              Width = 55
              Height = 13
              Caption = 'Logradouro'
            end
            object Label6: TLabel
              Left = 251
              Top = 57
              Width = 12
              Height = 13
              Caption = 'N'#186
            end
            object Label8: TLabel
              Left = 295
              Top = 57
              Width = 28
              Height = 13
              Caption = 'Bairro'
            end
            object Label9: TLabel
              Left = 447
              Top = 57
              Width = 43
              Height = 13
              Caption = 'Munic'#237'pio'
            end
            object Label10: TLabel
              Left = 598
              Top = 57
              Width = 79
              Height = 13
              Caption = 'C'#243'digo Munic'#237'pio'
            end
            object Label11: TLabel
              Left = 686
              Top = 57
              Width = 19
              Height = 13
              Caption = 'CEP'
            end
            object Label12: TLabel
              Left = 758
              Top = 57
              Width = 59
              Height = 13
              Caption = 'C'#243'digo IBGE'
            end
            object edtRemetenteCNPJ: TEditFocus
              Tag = 99
              Left = 11
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              TabOrder = 0
              OnExit = edtRemetenteCNPJExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteRazaoSocial: TEditFocus
              Left = 115
              Top = 34
              Width = 527
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteIE: TEditFocus
              Left = 644
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteUF: TEditFocus
              Left = 11
              Top = 73
              Width = 22
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteLogradouro: TEditFocus
              Left = 37
              Top = 73
              Width = 210
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteNumero: TEditFocus
              Left = 251
              Top = 73
              Width = 40
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteBairro: TEditFocus
              Left = 295
              Top = 73
              Width = 149
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteMunicipio: TEditFocus
              Left = 447
              Top = 73
              Width = 148
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteCodigoMunicipio: TEditFocus
              Left = 598
              Top = 73
              Width = 85
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteCEP: TEditFocus
              Left = 686
              Top = 73
              Width = 69
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRemetenteCodigoIBGE: TEditFocus
              Left = 758
              Top = 73
              Width = 59
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
      object tbsEmitente: TTabSheet
        Caption = 'Emitente'
        ImageIndex = 1
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 894
          Height = 159
          Align = alClient
          Padding.Left = 5
          Padding.Top = 5
          Padding.Right = 5
          Padding.Bottom = 5
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object grbEmitente: TGroupBox
            Left = 6
            Top = 6
            Width = 882
            Height = 106
            Align = alTop
            Caption = 'Emitente'
            Padding.Left = 10
            Padding.Right = 10
            TabOrder = 0
            object Label14: TLabel
              Left = 11
              Top = 18
              Width = 48
              Height = 13
              Caption = 'CNPJ/CPF'
            end
            object Label15: TLabel
              Left = 115
              Top = 18
              Width = 60
              Height = 13
              Caption = 'Raz'#227'o Social'
            end
            object Label16: TLabel
              Left = 644
              Top = 18
              Width = 87
              Height = 13
              Caption = 'Inscri'#231#227'o Estadual'
            end
            object Label17: TLabel
              Left = 11
              Top = 57
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object Label18: TLabel
              Left = 37
              Top = 57
              Width = 55
              Height = 13
              Caption = 'Logradouro'
            end
            object Label19: TLabel
              Left = 251
              Top = 57
              Width = 12
              Height = 13
              Caption = 'N'#186
            end
            object Label20: TLabel
              Left = 295
              Top = 57
              Width = 28
              Height = 13
              Caption = 'Bairro'
            end
            object Label23: TLabel
              Left = 686
              Top = 57
              Width = 19
              Height = 13
              Caption = 'CEP'
            end
            object Label24: TLabel
              Left = 758
              Top = 57
              Width = 59
              Height = 13
              Caption = 'C'#243'digo IBGE'
            end
            object Label21: TLabel
              Left = 447
              Top = 57
              Width = 43
              Height = 13
              Caption = 'Munic'#237'pio'
            end
            object Label22: TLabel
              Left = 599
              Top = 57
              Width = 79
              Height = 13
              Caption = 'C'#243'digo Munic'#237'pio'
            end
            object edtEmitenteCNPJ: TEditFocus
              Tag = 99
              Left = 11
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteRazaoSocial: TEditFocus
              Left = 115
              Top = 34
              Width = 526
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteIE: TEditFocus
              Left = 644
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteUF: TEditFocus
              Left = 11
              Top = 73
              Width = 22
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteLogradouro: TEditFocus
              Left = 37
              Top = 73
              Width = 210
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteNumero: TEditFocus
              Left = 251
              Top = 73
              Width = 40
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteBairro: TEditFocus
              Left = 295
              Top = 73
              Width = 149
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteMunicipio: TEditFocus
              Left = 447
              Top = 73
              Width = 148
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteCodigoMunicipio: TEditFocus
              Left = 598
              Top = 73
              Width = 85
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteCEP: TEditFocus
              Left = 686
              Top = 73
              Width = 69
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEmitenteCodigoIBGE: TEditFocus
              Left = 758
              Top = 73
              Width = 59
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
      object tbsDestinatario: TTabSheet
        Caption = 'Destinat'#225'rio'
        ImageIndex = 2
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 894
          Height = 159
          Align = alClient
          Padding.Left = 5
          Padding.Top = 5
          Padding.Right = 5
          Padding.Bottom = 5
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object grbDestinatario: TGroupBox
            Left = 6
            Top = 6
            Width = 882
            Height = 106
            Align = alTop
            Caption = 'Destinat'#225'rio'
            Padding.Left = 10
            Padding.Right = 10
            TabOrder = 0
            object Label25: TLabel
              Left = 11
              Top = 18
              Width = 48
              Height = 13
              Caption = 'CNPJ/CPF'
            end
            object Label26: TLabel
              Left = 115
              Top = 18
              Width = 60
              Height = 13
              Caption = 'Raz'#227'o Social'
            end
            object Label27: TLabel
              Left = 644
              Top = 18
              Width = 87
              Height = 13
              Caption = 'Inscri'#231#227'o Estadual'
            end
            object Label28: TLabel
              Left = 11
              Top = 57
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object Label29: TLabel
              Left = 37
              Top = 57
              Width = 55
              Height = 13
              Caption = 'Logradouro'
            end
            object Label30: TLabel
              Left = 251
              Top = 57
              Width = 12
              Height = 13
              Caption = 'N'#186
            end
            object Label31: TLabel
              Left = 295
              Top = 57
              Width = 28
              Height = 13
              Caption = 'Bairro'
            end
            object Label34: TLabel
              Left = 686
              Top = 57
              Width = 19
              Height = 13
              Caption = 'CEP'
            end
            object Label35: TLabel
              Left = 758
              Top = 57
              Width = 59
              Height = 13
              Caption = 'C'#243'digo IBGE'
            end
            object Label32: TLabel
              Left = 447
              Top = 57
              Width = 43
              Height = 13
              Caption = 'Munic'#237'pio'
            end
            object Label33: TLabel
              Left = 599
              Top = 57
              Width = 79
              Height = 13
              Caption = 'C'#243'digo Munic'#237'pio'
            end
            object edtDestinatarioCNPJ: TEditFocus
              Tag = 99
              Left = 11
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              TabOrder = 0
              OnExit = edtDestinatarioCNPJExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioRazaoSocial: TEditFocus
              Left = 115
              Top = 34
              Width = 526
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioIE: TEditFocus
              Left = 644
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioUF: TEditFocus
              Left = 11
              Top = 73
              Width = 22
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioLogradouro: TEditFocus
              Left = 37
              Top = 73
              Width = 210
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioNumero: TEditFocus
              Left = 251
              Top = 73
              Width = 40
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioBairro: TEditFocus
              Left = 295
              Top = 73
              Width = 149
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioMunicipio: TEditFocus
              Left = 447
              Top = 73
              Width = 148
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioCodigoMunicipio: TEditFocus
              Left = 598
              Top = 73
              Width = 85
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioCEP: TEditFocus
              Left = 686
              Top = 73
              Width = 69
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDestinatarioCodigoIBGE: TEditFocus
              Left = 758
              Top = 73
              Width = 59
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
      object tbsExpedidor: TTabSheet
        Caption = 'Expedidor'
        ImageIndex = 3
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 894
          Height = 159
          Align = alClient
          Padding.Left = 5
          Padding.Top = 5
          Padding.Right = 5
          Padding.Bottom = 5
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object grbExpedidor: TGroupBox
            Left = 6
            Top = 6
            Width = 882
            Height = 106
            Align = alTop
            Caption = 'Expedidor'
            Padding.Left = 10
            Padding.Right = 10
            TabOrder = 0
            object Label36: TLabel
              Left = 11
              Top = 18
              Width = 48
              Height = 13
              Caption = 'CNPJ/CPF'
            end
            object Label37: TLabel
              Left = 115
              Top = 18
              Width = 60
              Height = 13
              Caption = 'Raz'#227'o Social'
            end
            object Label38: TLabel
              Left = 644
              Top = 18
              Width = 87
              Height = 13
              Caption = 'Inscri'#231#227'o Estadual'
            end
            object Label39: TLabel
              Left = 11
              Top = 57
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object Label40: TLabel
              Left = 37
              Top = 57
              Width = 55
              Height = 13
              Caption = 'Logradouro'
            end
            object Label41: TLabel
              Left = 251
              Top = 57
              Width = 12
              Height = 13
              Caption = 'N'#186
            end
            object Label42: TLabel
              Left = 295
              Top = 57
              Width = 28
              Height = 13
              Caption = 'Bairro'
            end
            object Label45: TLabel
              Left = 686
              Top = 57
              Width = 19
              Height = 13
              Caption = 'CEP'
            end
            object Label46: TLabel
              Left = 758
              Top = 57
              Width = 59
              Height = 13
              Caption = 'C'#243'digo IBGE'
            end
            object Label43: TLabel
              Left = 447
              Top = 57
              Width = 43
              Height = 13
              Caption = 'Munic'#237'pio'
            end
            object Label44: TLabel
              Left = 599
              Top = 57
              Width = 79
              Height = 13
              Caption = 'C'#243'digo Munic'#237'pio'
            end
            object edtExpedidorCNPJ: TEditFocus
              Left = 11
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              TabOrder = 0
              OnExit = edtExpedidorCNPJExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorRazaoSocial: TEditFocus
              Left = 115
              Top = 34
              Width = 526
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorIE: TEditFocus
              Left = 644
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorUF: TEditFocus
              Left = 11
              Top = 73
              Width = 22
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorLogradouro: TEditFocus
              Left = 37
              Top = 73
              Width = 210
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorNumero: TEditFocus
              Left = 251
              Top = 73
              Width = 40
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorBairro: TEditFocus
              Left = 295
              Top = 73
              Width = 149
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorMunicipio: TEditFocus
              Left = 447
              Top = 73
              Width = 148
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorCodigoMunicipio: TEditFocus
              Left = 598
              Top = 73
              Width = 85
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorCEP: TEditFocus
              Left = 686
              Top = 73
              Width = 69
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtExpedidorCodigoIBGE: TEditFocus
              Left = 758
              Top = 73
              Width = 59
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
      object tbsRecebedor: TTabSheet
        Caption = 'Recebedor'
        ImageIndex = 4
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 894
          Height = 159
          Align = alClient
          Padding.Left = 5
          Padding.Top = 5
          Padding.Right = 5
          Padding.Bottom = 5
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object grbRecebedor: TGroupBox
            Left = 6
            Top = 6
            Width = 882
            Height = 106
            Align = alTop
            Caption = 'Recebedor'
            Padding.Left = 10
            Padding.Right = 10
            TabOrder = 0
            object Label47: TLabel
              Left = 11
              Top = 18
              Width = 48
              Height = 13
              Caption = 'CNPJ/CPF'
            end
            object Label48: TLabel
              Left = 115
              Top = 18
              Width = 60
              Height = 13
              Caption = 'Raz'#227'o Social'
            end
            object Label49: TLabel
              Left = 644
              Top = 18
              Width = 87
              Height = 13
              Caption = 'Inscri'#231#227'o Estadual'
            end
            object Label50: TLabel
              Left = 11
              Top = 57
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object Label51: TLabel
              Left = 37
              Top = 57
              Width = 55
              Height = 13
              Caption = 'Logradouro'
            end
            object Label52: TLabel
              Left = 251
              Top = 57
              Width = 12
              Height = 13
              Caption = 'N'#186
            end
            object Label53: TLabel
              Left = 295
              Top = 57
              Width = 28
              Height = 13
              Caption = 'Bairro'
            end
            object Label56: TLabel
              Left = 686
              Top = 57
              Width = 19
              Height = 13
              Caption = 'CEP'
            end
            object Label57: TLabel
              Left = 758
              Top = 57
              Width = 59
              Height = 13
              Caption = 'C'#243'digo IBGE'
            end
            object Label54: TLabel
              Left = 447
              Top = 57
              Width = 43
              Height = 13
              Caption = 'Munic'#237'pio'
            end
            object Label55: TLabel
              Left = 599
              Top = 57
              Width = 79
              Height = 13
              Caption = 'C'#243'digo Munic'#237'pio'
            end
            object edtRecebedorCNPJ: TEditFocus
              Left = 11
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              TabOrder = 0
              OnExit = edtRecebedorCNPJExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorRazaoSocial: TEditFocus
              Left = 115
              Top = 34
              Width = 526
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorIE: TEditFocus
              Left = 644
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorUF: TEditFocus
              Left = 11
              Top = 73
              Width = 22
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorLogradouro: TEditFocus
              Left = 37
              Top = 73
              Width = 210
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorNumero: TEditFocus
              Left = 251
              Top = 73
              Width = 40
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorBairro: TEditFocus
              Left = 295
              Top = 73
              Width = 149
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorMunicipio: TEditFocus
              Left = 447
              Top = 73
              Width = 148
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorCodigoMunicipio: TEditFocus
              Left = 598
              Top = 73
              Width = 85
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorCEP: TEditFocus
              Left = 686
              Top = 73
              Width = 69
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRecebedorCodigoIBGE: TEditFocus
              Left = 758
              Top = 73
              Width = 59
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
      object tbsTomador: TTabSheet
        Caption = 'Tomador'
        ImageIndex = 5
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 894
          Height = 159
          Align = alClient
          Padding.Left = 5
          Padding.Top = 5
          Padding.Right = 5
          Padding.Bottom = 5
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object grbTomador: TGroupBox
            Left = 6
            Top = 6
            Width = 882
            Height = 106
            Align = alTop
            Caption = 'Tomador'
            Enabled = False
            Padding.Left = 10
            Padding.Right = 10
            TabOrder = 0
            object Label58: TLabel
              Left = 11
              Top = 18
              Width = 48
              Height = 13
              Caption = 'CNPJ/CPF'
            end
            object Label59: TLabel
              Left = 115
              Top = 18
              Width = 60
              Height = 13
              Caption = 'Raz'#227'o Social'
            end
            object Label60: TLabel
              Left = 644
              Top = 18
              Width = 87
              Height = 13
              Caption = 'Inscri'#231#227'o Estadual'
            end
            object Label61: TLabel
              Left = 11
              Top = 57
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object Label62: TLabel
              Left = 37
              Top = 57
              Width = 55
              Height = 13
              Caption = 'Logradouro'
            end
            object Label63: TLabel
              Left = 251
              Top = 57
              Width = 12
              Height = 13
              Caption = 'N'#186
            end
            object Label64: TLabel
              Left = 295
              Top = 57
              Width = 28
              Height = 13
              Caption = 'Bairro'
            end
            object Label67: TLabel
              Left = 758
              Top = 57
              Width = 59
              Height = 13
              Caption = 'C'#243'digo IBGE'
            end
            object Label68: TLabel
              Left = 686
              Top = 57
              Width = 19
              Height = 13
              Caption = 'CEP'
            end
            object Label65: TLabel
              Left = 447
              Top = 57
              Width = 43
              Height = 13
              Caption = 'Munic'#237'pio'
            end
            object Label66: TLabel
              Left = 599
              Top = 57
              Width = 79
              Height = 13
              Caption = 'C'#243'digo Munic'#237'pio'
            end
            object edtTomadorCNPJ: TEditFocus
              Tag = 99
              Left = 13
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorRazaoSocial: TEditFocus
              Left = 115
              Top = 34
              Width = 526
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorIE: TEditFocus
              Left = 644
              Top = 34
              Width = 100
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorUF: TEditFocus
              Left = 11
              Top = 73
              Width = 22
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorLogradouro: TEditFocus
              Left = 37
              Top = 73
              Width = 210
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorNumero: TEditFocus
              Left = 251
              Top = 73
              Width = 40
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorBairro: TEditFocus
              Left = 295
              Top = 73
              Width = 149
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorMunicipio: TEditFocus
              Left = 447
              Top = 73
              Width = 148
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorCodigoMunicipio: TEditFocus
              Left = 598
              Top = 73
              Width = 85
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorCEP: TEditFocus
              Left = 686
              Top = 73
              Width = 69
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtTomadorCodigoIBGE: TEditFocus
              Left = 758
              Top = 73
              Width = 59
              Height = 21
              Alignment = taLeftJustify
              Enabled = False
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
    end
  end
end
