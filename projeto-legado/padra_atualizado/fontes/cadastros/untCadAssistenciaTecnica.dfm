inherited frmCadAssistenciaTecnica: TfrmCadAssistenciaTecnica
  Width = 753
  Height = 359
  Caption = 'Cadastro de Assist'#234'ncia T'#233'cnica'
  OnDestroy = FormDestroy
  ExplicitWidth = 753
  ExplicitHeight = 359
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 286
    Width = 747
    ExplicitTop = 286
    ExplicitWidth = 747
    inherited FlwBotoes: TFlowPanel
      Width = 743
      ExplicitTop = 2
      ExplicitWidth = 743
      object btnVisualizar: TBitBtnLocked
        Left = 432
        Top = 0
        Width = 75
        Height = 20
        Caption = 'Imprimir'
        TabOrder = 6
        OnClick = btnVisualizarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 664
      ExplicitLeft = 664
    end
  end
  inherited pnlStatus: TPanel
    Top = 314
    Width = 747
    ExplicitTop = 314
    ExplicitWidth = 747
    inherited pnlNomeForm: TPanel
      Left = 400
      ExplicitLeft = 400
    end
    inherited pnlInfo: TPanel
      Width = 400
      ExplicitWidth = 400
    end
  end
  inherited pgcDados: TPageControl
    Width = 747
    Height = 286
    ActivePage = tbsContato
    ExplicitWidth = 747
    ExplicitHeight = 286
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 739
      ExplicitHeight = 254
      object Label1: TLabel
        Left = 9
        Top = 24
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 15
        Top = 47
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object lblSituacao: TLabel
        Left = 3
        Top = 72
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Situa'#231#227'o:'
      end
      object ColorLabel1: TColorLabel
        Left = 77
        Top = 72
        Width = 75
        Height = 14
        Caption = '(A)tivo (I)nativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object dbeCodigo: TDBEditFocus
        Left = 51
        Top = 19
        Width = 121
        Height = 22
        DataField = 'ATC_CODIGO'
        DataSource = dtsAssitencias
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNome: TDBEditFocus
        Tag = 99
        Left = 51
        Top = 44
        Width = 355
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ATC_NOMEMP'
        DataSource = dtsAssitencias
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeSituacao: TDBEditFocus
        Tag = 99
        Left = 52
        Top = 72
        Width = 19
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ATC_SITUAC'
        DataSource = dtsAssitencias
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object tbsEnderecos: TTabSheet
      Caption = '&2 - Endere'#231'os'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFrmEnderecos: TPanel
        Left = 0
        Top = 0
        Width = 739
        Height = 417
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlFrmEnderecos'
        ShowCaption = False
        TabOrder = 0
        object lblCep: TLabel
          Left = 32
          Top = 8
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'CEP:'
        end
        object lblCidade: TLabel
          Left = 139
          Top = 7
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
        end
        object lblEstado: TLabel
          Left = 439
          Top = 7
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
        end
        object lblBairro: TLabel
          Left = 22
          Top = 35
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Bairro:'
        end
        object lblEndereco: TLabel
          Left = 5
          Top = 63
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o:'
        end
        object Label4: TLabel
          Left = 528
          Top = 8
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object ColorLabel2: TColorLabel
          Left = 603
          Top = 6
          Width = 75
          Height = 14
          Caption = '(A)tivo (I)nativo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtEndCep: TMaskEditFocus
          Tag = 99
          Left = 56
          Top = 3
          Width = 69
          Height = 22
          EditMask = '99999\-999;0;_'
          MaxLength = 9
          TabOrder = 0
          Text = ''
          OnKeyPress = edtEndCepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtCidade: TEditFocus
          Tag = 99
          Left = 222
          Top = 3
          Width = 194
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEstado: TEditFocus
          Left = 479
          Top = 3
          Width = 41
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtBairro: TEditFocus
          Tag = 99
          Left = 56
          Top = 31
          Width = 249
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEndereco: TEditFocus
          Tag = 99
          Left = 56
          Top = 60
          Width = 510
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnAddEnd: TBitBtnLocked
          Tag = 99
          Left = 576
          Top = 60
          Width = 74
          Height = 22
          Caption = '&Adicionar'
          Enabled = False
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 7
          OnClick = btnAddEndClick
        end
        object btnCanEnd: TBitBtnLocked
          Left = 656
          Top = 60
          Width = 74
          Height = 22
          Caption = 'C&ancelar'
          Enabled = False
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 8
          OnClick = btnCanEndClick
        end
        object edtEndSit: TEditFocus
          Tag = 99
          Left = 579
          Top = 3
          Width = 20
          Height = 22
          Alignment = taLeftJustify
          AutoSelect = False
          AutoSize = False
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
        object edtCodCid: TEditFocus
          Tag = 99
          Left = 176
          Top = 3
          Width = 44
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 44
          NumbersOnly = True
          TabOrder = 1
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
      end
      object pnlGridEnderecos: TPanel
        Left = 0
        Top = 88
        Width = 739
        Height = 166
        Align = alBottom
        Caption = 'pnlGridEnderecos'
        TabOrder = 1
        object dbgEndereco: TDBGridCitel
          Left = 1
          Top = 1
          Width = 737
          Height = 164
          Align = alClient
          DataSource = dtsEnderecos
          Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDblClick = dbgEnderecoDblClick
          OnKeyDown = dbgEnderecoKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              ReadOnly = True
              Title.Caption = 'Unidade'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CID_ESTADO'
              Title.Caption = 'Estado'
              Width = 43
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CID_NOMCID'
              Title.Caption = 'Cidade'
              Width = 74
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'AEN_ENDBAI'
              Title.Caption = 'Bairro'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'AEN_ENDEND'
              Title.Caption = 'Endere'#231'o'
              Width = 190
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'AEN_ENDCEP'
              Title.Caption = 'CEP'
              Width = 70
              Visible = True
            end>
        end
      end
    end
    object tbsContato: TTabSheet
      Caption = '&3 - Contato'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFrmContato: TPanel
        Left = 0
        Top = 0
        Width = 382
        Height = 254
        Align = alLeft
        Caption = 'pnlFrmContato'
        ShowCaption = False
        TabOrder = 0
        object lblNome: TLabel
          Left = 35
          Top = 31
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object lblDescricao: TLabel
          Left = 12
          Top = 107
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
        end
        object lblTipoContato: TLabel
          Left = 42
          Top = 57
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo:'
        end
        object lblAssistencia: TLabel
          Left = 22
          Top = 82
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object edtCttPessoa: TEditFocus
          Tag = 99
          Left = 70
          Top = 29
          Width = 171
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 60
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object cboCttTipo: TComboBox
          Left = 70
          Top = 54
          Width = 171
          Height = 22
          Style = csDropDownList
          Enabled = False
          TabOrder = 1
          OnChange = cboCttTipoChange
          Items.Strings = (
            '0-Telefone'
            '1-Celular'
            '2-Email'
            '3-WhatsApp'
            '4-Telegram'
            '5-Instagram')
        end
        object btnAddCtt: TBitBtnLocked
          Left = 70
          Top = 188
          Width = 74
          Height = 22
          Caption = '&Adicionar'
          Enabled = False
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 5
          OnClick = btnAddCttClick
        end
        object btnCanCtt: TBitBtnLocked
          Left = 150
          Top = 188
          Width = 74
          Height = 22
          Caption = 'C&ancelar'
          Enabled = False
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 6
          OnClick = btnCanCttClick
        end
        object mmoCttDescricao: TMemo
          Tag = 99
          Left = 70
          Top = 104
          Width = 299
          Height = 81
          MaxLength = 256
          TabOrder = 4
          Visible = False
        end
        object medCttDes: TMaskEditFocus
          Left = 70
          Top = 104
          Width = 171
          Height = 22
          EditMask = '!\(99\)99999-9999;0;_'
          MaxLength = 14
          TabOrder = 3
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object cboUnidade: TComboBox
          Left = 70
          Top = 79
          Width = 299
          Height = 22
          Style = csDropDownList
          Enabled = False
          TabOrder = 2
        end
        object btnExcluirContato: TBitBtnLocked
          Left = 230
          Top = 188
          Width = 75
          Height = 22
          Caption = 'Excluir'
          Enabled = False
          TabOrder = 7
          OnClick = btnExcluirContatoClick
        end
      end
      object pnlGridContato: TPanel
        Left = 382
        Top = 0
        Width = 357
        Height = 254
        Align = alClient
        Caption = 'pnlGridContato'
        TabOrder = 1
        object dbgContato: TDBGridCitel
          Left = 1
          Top = 1
          Width = 355
          Height = 252
          Align = alClient
          DataSource = dtsContatos
          Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDblClick = dbgContatoDblClick
          OnKeyDown = dbgContatoKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'ACT_TIPO__'
              Title.Caption = 'Tipo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ACT_PESSOA'
              Title.Caption = 'Nome'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ACT_DESCRI'
              Title.Caption = 'Descri'#231#227'o'
              Width = 190
              Visible = True
            end>
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 632
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 128
  end
  object dtsAssitencias: TDataSource
    AutoEdit = False
    OnStateChange = dtsAssitenciasStateChange
    OnDataChange = dtsAssitenciasDataChange
    Left = 588
    Top = 212
  end
  object dtsEnderecos: TDataSource
    AutoEdit = False
    Left = 676
    Top = 188
  end
  object dtsContatos: TDataSource
    AutoEdit = False
    Left = 388
    Top = 204
  end
  object frxReport1: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44854.667024039400000000
    ReportOptions.LastChange = 44869.283863506900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 338
    Top = 60
    Datasets = <
      item
        DataSet = frxCadATC
        DataSetName = 'frxCadATC'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 702.992580000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FORMUL'#193'RIO DE ASSIST'#202'NCIA T'#201'CNICA')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        DataSet = frxCadATC
        DataSetName = 'frxCadATC'
        RowCount = 0
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 132.283550000000000000
        Width = 718.110700000000000000
        Condition = 'frxCadATC."ATC_CODIGO"'
        object frxCadATCATC_NOMEMP: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nome da Assist'#234'ncia: [frxCadATC."ATC_NOMEMP"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 181.417440000000000000
        Width = 718.110700000000000000
        Condition = '<frxCadATC."GRUPO">='#39'1'#39
        object Memo3: TfrxMemoView
          Left = 37.795275590000000000
          Width = 204.094620000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contatos Gerais:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 75.590600000000000000
          Top = 21.677180000000000000
          Width = 180.661417320000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 256.008040000000000000
          Top = 21.677180000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Tipo/canal')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 361.834880000000000000
          Top = 21.677180000000000000
          Width = 351.496290000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        DataSet = frxCadATC
        DataSetName = 'frxCadATC'
        Filter = '<frxCadATC."GRUPO">='#39'1'#39
        RowCount = 0
        Stretched = True
        object frxCadATCACT_PESSOA: TfrxMemoView
          Left = 75.590551181102400000
          Width = 180.661417322835000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'ACT_PESSOA'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."ACT_PESSOA"]')
          ParentFont = False
        end
        object frxCadATCACT_TIPO__: TfrxMemoView
          Left = 255.874015750000000000
          Width = 105.826771653543000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'ACT_TIPO__'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."ACT_TIPO__"]')
          ParentFont = False
        end
        object frxCadATCACT_DESCRI: TfrxMemoView
          Left = 361.700787400000000000
          Width = 351.496062990000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'ACT_DESCRI'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."ACT_DESCRI"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 283.464750000000000000
        Width = 718.110700000000000000
      end
      object GroupHeader3: TfrxGroupHeader
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 374.173470000000000000
        Width = 718.110700000000000000
        Condition = 'frxCadATC."INCEND"'
        object Memo7: TfrxMemoView
          Left = 11.338590000000000000
          Top = 2.015770000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'Estado')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 64.031540000000000000
          Top = 1.944881890000000000
          Width = 272.126160000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Cidade')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 335.937230000000000000
          Top = 1.944881890000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 430.488188980000000000
          Top = 1.944881890000000000
          Width = 283.464750000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Bairro')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 11.338590000000000000
          Top = 31.811070000000000000
          Width = 702.614173230000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 75.590551180000000000
          Top = 79.267780000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Contatos')
          ParentFont = False
        end
        object frxCadATCAEN_ENDEND: TfrxMemoView
          Left = 11.338590000000000000
          Top = 46.929190000000000000
          Width = 702.614173230000000000
          Height = 15.118110240000000000
          DataField = 'AEN_ENDEND'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."AEN_ENDEND"]')
          ParentFont = False
        end
        object frxCadATCCID_ESTADO: TfrxMemoView
          Left = 11.338590000000000000
          Top = 16.354360000000000000
          Width = 52.913385830000000000
          Height = 15.118110240000000000
          DataField = 'CID_ESTADO'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."CID_ESTADO"]')
          ParentFont = False
        end
        object frxCadATCCID_NOMCID: TfrxMemoView
          Left = 63.874015750000000000
          Top = 16.251968500000000000
          Width = 272.126160000000000000
          Height = 15.118110240000000000
          DataField = 'CID_NOMCID'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."CID_NOMCID"]')
          ParentFont = False
        end
        object frxCadATCAEN_ENDCEP: TfrxMemoView
          Left = 336.000000000000000000
          Top = 16.251968500000000000
          Width = 94.488250000000000000
          Height = 15.118110240000000000
          DataField = 'AEN_ENDCEP'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."AEN_ENDCEP"]')
          ParentFont = False
        end
        object frxCadATCAEN_ENDBAI: TfrxMemoView
          Left = 430.110236220000000000
          Top = 16.251968500000000000
          Width = 283.464566929134000000
          Height = 15.118110240000000000
          DataField = 'AEN_ENDBAI'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."AEN_ENDBAI"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 76.590600000000000000
          Top = 98.267780000000000000
          Width = 180.661417320000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 257.008040000000000000
          Top = 98.267780000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Tipo/canal')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 362.834880000000000000
          Top = 98.267780000000000000
          Width = 351.496290000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Contato')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Width = 718.110236220472000000
          Color = clBlack
          Diagonal = True
        end
      end
      object DetailData2: TfrxDetailData
        FillType = ftBrush
        Height = 17.118120000000000000
        Top = 510.236550000000000000
        Width = 718.110700000000000000
        DataSet = frxCadATC
        DataSetName = 'frxCadATC'
        Filter = '<frxCadATC."GRUPO">='#39'2'#39
        RowCount = 0
        Stretched = True
        object frxCadATCACT_PESSOA1: TfrxMemoView
          Left = 76.724409450000000000
          Width = 180.661417320000000000
          Height = 15.118110240000000000
          DataField = 'ACT_PESSOA'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."ACT_PESSOA"]')
          ParentFont = False
        end
        object frxCadATCACT_TIPO__1: TfrxMemoView
          Left = 257.007874020000000000
          Width = 105.826771650000000000
          Height = 15.118110240000000000
          DataField = 'ACT_TIPO__'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."ACT_TIPO__"]')
          ParentFont = False
        end
        object frxCadATCACT_DESCRI1: TfrxMemoView
          Left = 362.834645670000000000
          Width = 351.496062990000000000
          Height = 15.118110240000000000
          StretchMode = smMaxHeight
          DataField = 'ACT_DESCRI'
          DataSet = frxCadATC
          DataSetName = 'frxCadATC'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxCadATC."ACT_DESCRI"]')
          ParentFont = False
        end
      end
      object GroupHeader5: TfrxGroupHeader
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 321.260050000000000000
        Width = 718.110700000000000000
        Condition = '<frxCadATC."GRUPO">='#39'2'#39
        object Memo6: TfrxMemoView
          Left = 11.338582680000000000
          Top = 3.000000000000000000
          Width = 257.008040000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Unidades - endere'#231'os')
          ParentFont = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 551.811380000000000000
        Width = 718.110700000000000000
      end
      object GroupFooter3: TfrxGroupFooter
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 582.047620000000000000
        Width = 718.110700000000000000
      end
    end
  end
  object frxCadATC: TfrxDBDataset
    UserName = 'frxCadATC'
    CloseDataSource = False
    FieldAliases.Strings = (
      'AUTOINCREM=AUTOINCREM'
      'ATC_CODIGO=ATC_CODIGO'
      'ATC_SITUAC=ATC_SITUAC'
      'ATC_CODEMP=ATC_CODEMP'
      'ATC_NOMEMP=ATC_NOMEMP'
      'GRUPO=GRUPO'
      'INCEND=INCEND'
      'AEN_SITUAC=AEN_SITUAC'
      'AEN_ENDCID=AEN_ENDCID'
      'AEN_ENDCEP=AEN_ENDCEP'
      'AEN_ENDBAI=AEN_ENDBAI'
      'AEN_ENDEND=AEN_ENDEND'
      'CID_NOMCID=CID_NOMCID'
      'CID_ESTADO=CID_ESTADO'
      'ACT_TIPO__=ACT_TIPO__'
      'ACT_DESCRI=ACT_DESCRI'
      'ACT_PESSOA=ACT_PESSOA')
    BCDToCurrency = False
    Left = 290
    Top = 60
  end
end
