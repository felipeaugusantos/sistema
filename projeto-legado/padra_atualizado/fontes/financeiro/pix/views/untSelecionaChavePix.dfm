inherited frmSelecionaChavePix: TfrmSelecionaChavePix
  Width = 539
  Height = 232
  Caption = 'Selecionar Chave Pix'
  Position = poScreenCenter
  ExplicitWidth = 539
  ExplicitHeight = 232
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 161
    Width = 533
    ExplicitTop = 177
    ExplicitWidth = 479
    inherited FlwBotoes: TFlowPanel
      Width = 529
      ExplicitWidth = 475
    end
    inherited btnSair: TBitBtnLocked
      Left = 450
      ExplicitLeft = 396
    end
  end
  inherited pnlStatus: TPanel
    Top = 187
    Width = 533
    ExplicitTop = 203
    ExplicitWidth = 479
    inherited pnlNomeForm: TPanel
      Left = 362
      ExplicitLeft = 308
    end
    inherited pnlInfo: TPanel
      Width = 362
      ExplicitWidth = 308
    end
  end
  object grpDadosChavePix: TGroupBox [2]
    Left = 8
    Top = 65
    Width = 517
    Height = 88
    Caption = 'Dados da chave Pix selecionada'
    TabOrder = 2
    object lblDadosChavePix: TLabel
      Left = 24
      Top = 16
      Width = 85
      Height = 14
      Caption = 'Dados da Conta'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlChavePixCadastrada: TPanel [3]
    Left = 8
    Top = 8
    Width = 522
    Height = 26
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    inline fraGerarPixBoleto: TfraGerarPixBoleto
      Left = -76
      Top = 1
      Width = 598
      Height = 21
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = -76
      ExplicitTop = 1
      ExplicitWidth = 598
      ExplicitHeight = 21
      inherited pnlChavePix: TPanel
        Width = 598
        Height = 21
        ExplicitWidth = 609
        ExplicitHeight = 21
        inherited lblGerarPix: TLabel
          Left = 557
          Top = -10
          Visible = False
          ExplicitLeft = 557
          ExplicitTop = -10
        end
        inherited lblGerarPixSN: TColorLabel
          Left = 713
          Top = -10
          Width = 55
          Height = 14
          Visible = False
          ExplicitLeft = 713
          ExplicitTop = -10
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited lblChavePix: TLabel
          Left = 76
          Top = 4
          ExplicitLeft = 76
          ExplicitTop = 4
        end
        inherited edtGerarPix: TEditFocus
          Left = 688
          Top = -13
          Width = 19
          Height = 20
          Text = 'S'
          Visible = False
          ExplicitLeft = 688
          ExplicitTop = -13
          ExplicitWidth = 19
          ExplicitHeight = 20
        end
        inherited cmbChavePix: TcxLookupComboBox
          Tag = 99
          Left = 185
          Properties.ListColumns = <
            item
              FieldName = 'CHAVE'
            end>
          Properties.ListOptions.SyncMode = True
          Properties.OnEditValueChanged = fraGerarPixBoletocmbChavePixPropertiesEditValueChanged
          ExplicitLeft = 185
          ExplicitWidth = 407
          ExplicitHeight = 22
          Width = 407
        end
      end
    end
  end
  object pnlChavePixNaoCadastrada: TPanel [4]
    Left = 8
    Top = 19
    Width = 522
    Height = 27
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object lblTipoPix: TLabel
      Left = 7
      Top = 4
      Width = 55
      Height = 14
      Caption = 'Tipo do Pix:'
    end
    object lblChave: TLabel
      Left = 229
      Top = 4
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Chave:'
    end
    object cmbTipoDoPix: TComboBoxFocus
      Tag = 99
      Left = 68
      Top = 1
      Width = 155
      Height = 22
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbTipoDoPixChange
      Items.Strings = (
        '1-CNPJ / 2-CPF'
        'Celular'
        'Email'
        'Chave Aleat'#243'ria')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtCPFCNPJPix: TEditFocus
      Tag = 99
      Left = 265
      Top = 1
      Width = 27
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 1
      OnEnter = edtCPFCNPJPixEnter
      OnExit = edtCPFCNPJPixExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttInteiro
    end
    object edtChavePix: TEditFocus
      Tag = 99
      Left = 292
      Top = 1
      Width = 224
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 14
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
  end
  object chkChavePix: TCheckBox [5]
    Left = 8
    Top = 42
    Width = 137
    Height = 17
    Caption = 'Chave Pix Cadastrada'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = chkChavePixClick
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 384
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
    Top = 320
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 344
  end
end
