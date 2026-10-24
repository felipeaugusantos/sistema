unit untReplicacaoLotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxCheckBox, Uni, UniClientDataSet, MemDS,
  DBAccess, cxProgressBar, System.StrUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmReplicacaoLotes = class(TfrmPaiSimples)
    grbArmRep: TGroupBox;
    grdAmzRepLvl1: TcxGridLevel;
    grdAmzRepDados: TcxGridDBTableViewCitel;
    grdAmzRep: TcxGridCitel;
    grdAmzRepDadosSELECT: TcxGridDBColumn;
    grdAmzRepDadosCODAMZ: TcxGridDBColumn;
    grdAmzRepDadosDESCRI: TcxGridDBColumn;
    grdAmzRepDadosQTDREP: TcxGridDBColumn;
    grbPrgRep: TGroupBox;
    pgrGeral: TProgressBar;
    pgrDetalheEmp: TProgressBar;
    lblGeral: TLabel;
    lblDetalheEmp: TLabel;
    dtsAmzRep: TDataSource;
    lblDetalheItem: TLabel;
    pgrDetalheItem: TProgressBar;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    cdsAmzRep: TUniClientDataSet;
    stlEmpresas: TStringList;

    procedure pInicializarClientDataSet;
    procedure pIncializarComponentes;
    function  fGetQtdItensRepAmz(strCodAmz: String): Integer;
    function  fReplicarArmazem: Boolean;
    function  fAmzSelecionado: Boolean;
  public
    { Public declarations }
  end;

var
  frmReplicacaoLotes: TfrmReplicacaoLotes;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCadLote;

procedure TfrmReplicacaoLotes.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not fAmzSelecionado()) Then Begin
    fMensagem('ATENÇÃO!', 'Não existem armazéns selecionados para replicação!', ['&OK']);
    Exit;
  End;

  Try
    btnSair.Enabled     := False;
    btnConfirma.Enabled := False;

    pnlInfo.Caption   := 'Replicando armazéns, esse processo pode levar vários minutos, aguarde!';

    If (fReplicarArmazem()) Then Begin
      fMensagem('CONFIRMAÇÃO!', 'Replicação finalizada com sucesso!', ['&OK']);
      btnSair.Click();
    End;
  Finally
    btnSair.Enabled     := True;
    btnConfirma.Enabled := True;
    pnlInfo.Caption     := '';
  End;
end;

function TfrmReplicacaoLotes.fAmzSelecionado: Boolean;
begin
  Result := False;

  Try
    cdsAmzRep.DisableControls();
    cdsAmzRep.First();

    While (Not cdsAmzRep.Eof) Do Begin
      If (cdsAmzRep.FieldByName('SELECT').AsString = 'S') Then Begin
        Result := True;
        Break;
      End;

      cdsAmzRep.Next();
    End;
  Finally
    cdsAmzRep.EnableControls();
  End;
end;

function TfrmReplicacaoLotes.fGetQtdItensRepAmz(strCodAmz: String): Integer;
  Var
    qryTemp: TUniQuery;

  Const
    SQL_SELECT =
     'SELECT COUNT(ITE_CODITE) AS QTDREP FROM CADITE WHERE ITE_CODITE NOT IN ' +
       '(SELECT LOT_CODITE FROM CADLOT WHERE LOT_NUMLOT = :NUMLOT ' +
                                       ' AND LOT_CODEMP = :CODEMP) ' +
                                       ' AND ITE_ITEATI = "S"';
begin
  Result := 0;

  Try
    qryTemp := fCriaQuery(Self);

    Try
      //consulta a quantidade de itens ativos que não possui registro
      //na CADLOT para o armazém que será replicado
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := SQL_SELECT;
      qryTemp.ParamByName('NUMLOT').AsString := strCodAmz;
      qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryTemp.Open();
      qryTemp.First();

      Result := qryTemp.FieldByName('QTDREP').AsInteger;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmReplicacaoLotes.fGetQtdItensRepAmz]');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmReplicacaoLotes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsAmzRep);
  FreeAndNil(stlEmpresas);
end;

procedure TfrmReplicacaoLotes.FormCreate(Sender: TObject);
begin
  inherited;

  cdsAmzRep := nil;
end;

procedure TfrmReplicacaoLotes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) And (btnSair.Enabled) Then
    btnSair.Click()
  Else If (Key = VK_F10) And (btnConfirma.Enabled) Then
    btnConfirma.Click();
end;

procedure TfrmReplicacaoLotes.FormShow(Sender: TObject);
begin
  inherited;

  pIncializarComponentes();
  pInicializarClientDataSet();

  stlEmpresas := TStringList.Create;

  If (Not fCfgSis('AMZEMP', varBoolean)) Then Begin
    stlEmpresas.Text := VS_strCodEmp;
  End Else Begin
    If fUsaRotinaWMS Then
      stlEmpresas.Text := AnsiReplaceStr(fCampoTabela('GROUP_CONCAT(EMP_CODEMP)', 'CADEMP', ['EMP_UTIWMS'], ['S']),',', #13#10)
    Else
      stlEmpresas.Text := AnsiReplaceStr(fCampoTabela('GROUP_CONCAT(EMP_CODEMP)', 'CADEMP', [], []),',', #13#10);
  End;
end;

function TfrmReplicacaoLotes.fReplicarArmazem: Boolean;
  Var
    i: Integer;
    objCadLot: TCadLot;
    dteDtaBal: TDateTime;
    qryItens, qryGenerica: TUniQuery;
    fltSaldo, fltSaldoML: Double;

  Const
    SQL_ITENS =
     'SELECT ITE_CODITE FROM CADITE WHERE ITE_CODITE NOT IN ' +
       '(SELECT LOT_CODITE FROM CADLOT WHERE LOT_NUMLOT = :NUMLOT ' +
                                       ' AND LOT_CODEMP = :CODEMP) ' +
                                       ' AND ITE_ITEATI = "S"';

    procedure pInicializarProgressBar; begin
      pgrGeral.Min      := 0;
      pgrGeral.Max      := cdsAmzRep.RecordCount;
      pgrGeral.Position := 0;

      If (Not fCfgSis('AMZEMP', varBoolean)) Then Begin
        pgrDetalheEmp.Min      := 0;
        pgrDetalheEmp.Max      := stlEmpresas.Count;
        pgrDetalheEmp.Position := 0;
      End;

      grbPrgRep.Visible := True;
    end;

    procedure pInicializarProgressBarItens; begin
      pgrDetalheItem.Min      := 0;
      pgrDetalheItem.Max      := qryItens.RecordCount;
      pgrDetalheItem.Position := 0;
    end;

    function fRetDtaBal(strCodIte, strCodEmp: String): TDateTime;
      Var
        qryTemp: TUniQuery;
    begin
      Result := 0;

      Try
        qryTemp := fCriaQuery(Self);
        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := 'SELECT ITE_DTABAL FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
        qryTemp.ParamByName('CODITE').AsString := strCodIte;
        qryTemp.ParamByName('CODEMP').AsString := strCodEmp;
        qryTemp.Open();

        If (not qryTemp.IsEmpty) And (qryTemp.FieldByName('ITE_DTABAL').AsDateTime > 0) Then Begin
          Result := qryTemp.FieldByName('ITE_DTABAL').AsDateTime;
        End;
      Finally
        FreeAndNil(qryTemp);
      End;
    end;
begin
  Result := False;

  Try
    qryItens    := nil;
    objCadLot   := TCadLot.Create(Self);
    qryGenerica := fCriaQuery(Self);

    cdsAmzRep.DisableControls();
    cdsAmzRep.First();

    Try
      fStartTransaction();

      pInicializarProgressBar();

      //para cada armazém
      While (Not cdsAmzRep.Eof) Do Begin
        lblGeral.Caption := '   Armazém: ' + cdsAmzRep.FieldByName('CODAMZ').AsString
          + '-' + cdsAmzRep.FieldByName('DESCRI').AsString + '   ';

        If (cdsAmzRep.FieldByName('SELECT').AsString = 'N') Then Begin
          pgrGeral.Position := pgrGeral.Position + 1;
          cdsAmzRep.Next();
          Continue;
        End;

        //para cada empresa
        For i := 0 To stlEmpresas.Count - 1 Do Begin
          lblDetalheEmp.Caption := '   Replicando armazém na empresa: ' + stlEmpresas[i] + '-' +
            fRetNomeEmpresa(stlEmpresas[i]) + '   ';

          If (Not Assigned(qryItens)) Then
            qryItens := fCriaQuery(Self);

          qryItens.SQL.Clear();
          qryItens.SQL.Text := SQL_ITENS;
          qryItens.ParamByName('NUMLOT').AsString := cdsAmzRep.FieldByName('CODAMZ').AsString;
          qryItens.ParamByName('CODEMP').AsString := stlEmpresas[i];
          qryItens.Open();
          qryItens.First();

          pInicializarProgressBarItens();

          //para cada item
          While (Not qryItens.Eof) Do Begin
            If (
                 (fCfgSis('AMZEMP', varBoolean)) Or
                 (
                   (Not fCfgSis('AMZEMP', varBoolean)) And (stlEmpresas[i] = VS_strCodEmp)
                 )
               ) And
               (Not objCadLot.fExisteLote(qryItens.FieldByName('ITE_CODITE').AsString,
                                          stlEmpresas[i],
                                          cdsAmzRep.FieldByName('CODAMZ').AsString)) Then Begin
              With qryGenerica, SQL Do Begin
                Close;
                Clear;
                Add('SELECT * FROM CADLOT WHERE FALSE');
                Open;
                qryGenerica.Insert;

                If ( fCampoTabela('COUNT(LOT_NUMLOT)', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP'],
                       [qryItens.FieldByName('ITE_CODITE').AsString, stlEmpresas[i]]) = 0 ) Then Begin
                  fltSaldo := fRetSaldosEmpresa(qryItens.FieldByName('ITE_CODITE').AsString,
                                                stlEmpresas[i]);

                  If fUsaRotinaWMS Then
                    fltSaldoML := fRetSaldosMLEmpresa(qryItens.FieldByName('ITE_CODITE').AsString,
                                                      stlEmpresas[i])
                  Else
                    fltSaldoML := 0;
                End Else Begin
                  fltSaldo   := 0;
                  fltSaldoML := 0;
                End;

                FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', stlEmpresas[i]);
                FieldByName('LOT_NUMLOT').AsString   := cdsAmzRep.FieldByName('CODAMZ').AsString;
                FieldByName('LOT_CODEMP').AsString   := stlEmpresas[i];
                FieldByName('LOT_CODITE').AsString   := qryItens.FieldByName('ITE_CODITE').AsString;

                dteDtaBal := fRetDtaBal(qryItens.FieldByName('ITE_CODITE').AsString, stlEmpresas[i]);

                If (dteDtaBal = 0) Then
                  FieldByName('LOT_DTABAL').Value := Null
                Else
                  FieldByName('LOT_DTABAL').AsDateTime := dteDtaBal;

                FieldByName('LOT_SALBAL').AsFloat    := fltSaldo;
                FieldByName('LOT_SALDOS').AsFloat    := fltSaldo;
                FieldByName('LOT_ML_BAL').AsFloat    := fltSaldoML;
                FieldByName('LOT_SAL_ML').AsFloat    := fltSaldoML;
                FieldByName('LOT_SALCON').Value      := Null;
                FieldByName('LOT_DIGCON').AsString   := 'N';
                FieldByName('LOT_ORDCON').Value      := Null;
                FieldByName('LOT_DIFSAL').AsFloat    := 0;

                FieldByName('LOT_PRIPRO').AsString   := cdsAmzRep.FieldByName('PRIPRO').AsString;
                FieldByName('LOT_PRIIND').AsString   := cdsAmzRep.FieldByName('PRIIND').AsString;
                FieldByName('LOT_ARMPRC').AsString   := cdsAmzRep.FieldByName('ARMPRC').AsString;
                FieldByName('LOT_GARPRI').AsString   := cdsAmzRep.FieldByName('GARPRI').AsString;
                FieldByName('LOT_ARMPRI').AsString   := cdsAmzRep.FieldByName('ARMPRI').AsString;
                FieldByName('LOT_PRITIN').AsString   := cdsAmzRep.FieldByName('PRITIN').AsString;

                Post;
                Close;

                If (cdsAmzRep.FieldByName('ARMPRI').AsString = 'S') Then
                  objCadLot.pAjustaArmPrincipalVenda(cdsAmzRep.FieldByName('CODAMZ').AsString,
                    qryItens.FieldByName('ITE_CODITE').AsString);

                If (cdsAmzRep.FieldByName('ARMPRC').AsString = 'S') Then
                  objCadLot.pAjustaArmPrincipalCompra(cdsAmzRep.FieldByName('CODAMZ').AsString,
                    qryItens.FieldByName('ITE_CODITE').AsString);

                If (cdsAmzRep.FieldByName('GARPRI').AsString = 'S') Then
                  objCadLot.pAjustaArmPrincipalGarantia(cdsAmzRep.FieldByName('CODAMZ').AsString,
                    qryItens.FieldByName('ITE_CODITE').AsString);

                If (cdsAmzRep.FieldByName('PRIPRO').AsString = 'S') Then
                  objCadLot.pAjustaArmPrincipalProducao(cdsAmzRep.FieldByName('CODAMZ').AsString,
                    qryItens.FieldByName('ITE_CODITE').AsString);

                If (cdsAmzRep.FieldByName('PRIIND').AsString = 'S') Then
                  objCadLot.pAjustaArmPrincipalProducaoIndustrial(cdsAmzRep.FieldByName('CODAMZ').AsString,
                    qryItens.FieldByName('ITE_CODITE').AsString);

                If (cdsAmzRep.FieldByName('PRITIN').AsString = 'S') Then
                  objCadLot.pAjustaLotePrincipalTintaMaquina(cdsAmzRep.FieldByName('CODAMZ').AsString,
                    qryItens.FieldByName('ITE_CODITE').AsString);
              End;
            End;

            // CADASTRANDO O LOTE "A DEFINIR" EM CADA EMPRESA
            If (
                 (fCfgSis('AMZEMP', varBoolean)) Or
                 (
                   (Not fCfgSis('AMZEMP', varBoolean)) And (stlEmpresas[i] = VS_strCodEmp)
                 )
               ) And
               (Not objCadLot.fExisteLote(qryItens.FieldByName('ITE_CODITE').AsString,
                                stlEmpresas[i], 'A DEFINIR', False, False)) Then Begin

              With qryGenerica, SQL Do Begin
                Close;
                Clear;
                Add('SELECT * FROM CADLOT WHERE FALSE');
                Open;
                qryGenerica.Insert;

                FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', stlEmpresas[i]);
                FieldByName('LOT_NUMLOT').AsString   := 'A DEFINIR';
                FieldByName('LOT_CODEMP').AsString   := stlEmpresas[i];
                FieldByName('LOT_CODITE').AsString   := qryItens.FieldByName('ITE_CODITE').AsString;
                FieldByName('LOT_DTABAL').Value      := FieldByName('LOT_DTABAL').Value;
                FieldByName('LOT_SALBAL').AsFloat    := 0;
                FieldByName('LOT_SALDOS').AsFloat    := 0;
                FieldByName('LOT_ML_BAL').AsFloat    := 0;
                FieldByName('LOT_SAL_ML').AsFloat    := 0;
                FieldByName('LOT_SALCON').Value      := Null;
                FieldByName('LOT_DIGCON').AsString   := 'N';
                FieldByName('LOT_ORDCON').Value      := Null;
                FieldByName('LOT_DIFSAL').AsFloat    := 0;

                Post;
                Close;
              End;
            End;

            pgrDetalheItem.Position := pgrDetalheItem.Position + 1;

            lblDetalheItem.Caption := '   Processando itens: ' +
              IntToStr(qryItens.RecNo) + ' de ' + IntToStr(qryItens.RecordCount);

            qryItens.Next();

            Application.ProcessMessages();
          End;

          pgrDetalheEmp.Position := pgrDetalheEmp.Position + 1;

          FreeAndNil(qryItens);
        End;

        pgrGeral.Position := pgrGeral.Position + 1;
        cdsAmzRep.Next();
      End;

	    Result := fCommit();
    Except
      On E: Exception Do Begin
        fRollBack();
        pMensagensErro(E.Message, '[TfrmReplicacaoLotes.fReplicarArmazem]');
      End;
    End;
  Finally
    grbPrgRep.Visible := False;
    cdsAmzRep.EnableControls();
    FreeAndNil(qryGenerica);
  End;
end;

procedure TfrmReplicacaoLotes.pIncializarComponentes;
begin
  lblGeral.Caption       := '   Armazém: xxx   ';
  lblDetalheEmp.Caption  := '   Replicando armazém na empresa: xxx   ';
  lblDetalheItem.Caption := '   Replicando armazém para os produtos, aguarde...   ';
  lblDetalheEmp.Visible  := (fCfgSis('AMZEMP', varBoolean));

  pgrGeral.Min      := 0;
  pgrGeral.Max      := 0;
  pgrGeral.Position := 0;

  pgrDetalheItem.Min      := 0;
  pgrDetalheItem.Max      := 0;
  pgrDetalheItem.Position := 0;

  pgrDetalheEmp.Min      := 0;
  pgrDetalheEmp.Max      := 0;
  pgrDetalheEmp.Position := 0;
  pgrDetalheEmp.Visible  := (fCfgSis('AMZEMP', varBoolean));

  grbPrgRep.Visible := False;

  If (Not fCfgSis('AMZEMP', varBoolean)) Then
    grbPrgRep.Height := lblGeral.Height + lblDetalheItem.Height +
      pgrGeral.Height + pgrDetalheItem.Height + 5;
end;

procedure TfrmReplicacaoLotes.pInicializarClientDataSet;
  Var
    qryTemp: TUniQuery;

  Const
    SQL_SELECT =
     ' SELECT AMZ_CODAMZ AS CODAMZ, AMZ_DESCRI AS DESCRI, ' +
        ' AMZ_ARMPRI AS ARMPRI, AMZ_ARMPRC AS ARMPRC, AMZ_GARPRI AS GARPRI, ' +
        ' AMZ_PRIPRO AS PRIPRO, AMZ_PRIIND AS PRIIND, AMZ_PRITIN AS PRITIN ' +
     ' FROM CADAMZ WHERE AMZ_REPAMZ = "S" ORDER BY AMZ_DESCRI ';

  procedure pInicializarClient; begin
    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'SELECT';
      DataType := ftString;
      Size     := 1;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'CODAMZ';
      DataType := ftString;
      Size     := 3;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'DESCRI';
      DataType := ftString;
      Size     := 20;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'QTDREP';
      DataType := ftInteger;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'ARMPRI';
      DataType := ftString;
      Size     := 1;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'ARMPRC';
      DataType := ftString;
      Size     := 1;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'GARPRI';
      DataType := ftString;
      Size     := 1;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'PRIPRO';
      DataType := ftString;
      Size     := 1;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'PRITIN';
      DataType := ftString;
      Size     := 1;
    End;

    With cdsAmzRep.FieldDefs.AddFieldDef Do Begin
      Name     := 'PRIIND';
      DataType := ftString;
      Size     := 1;
    End;

    cdsAmzRep.CreateDataSet();
    cdsAmzRep.EmptyDataSet();
  end;
begin
  Try
    qryTemp   := fCriaQuery(Self);
    cdsAmzRep := TUniClientDataSet.Create(Self);

    pInicializarClient();

    Try
      //buscar armazéns disponíveis para replicação
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := SQL_SELECT;
      qryTemp.Open();
      qryTemp.First();

      If (qryTemp.IsEmpty) Then Begin
        //caso não houver armazéns para replicação fechar a tela
        fMensagem('ALERTA!', 'Não existem armazéns cadastrados para replicação!', ['&OK']);
      End Else Begin
        //caso houver armazéns para replicação, verificar quantos itens deverão ser processados para cada um
        While (Not qryTemp.Eof) Do Begin
          cdsAmzRep.Append();

          cdsAmzRep.FieldByName('SELECT').AsString  := 'N';
          cdsAmzRep.FieldByName('CODAMZ').AsString  := qryTemp.FieldByName('CODAMZ').AsString;
          cdsAmzRep.FieldByName('DESCRI').AsString  := qryTemp.FieldByName('DESCRI').AsString;

          cdsAmzRep.FieldByName('ARMPRI').AsString  := qryTemp.FieldByName('ARMPRI').AsString;
          cdsAmzRep.FieldByName('ARMPRC').AsString  := qryTemp.FieldByName('ARMPRC').AsString;
          cdsAmzRep.FieldByName('GARPRI').AsString  := qryTemp.FieldByName('GARPRI').AsString;
          cdsAmzRep.FieldByName('PRIPRO').AsString  := qryTemp.FieldByName('PRIPRO').AsString;
          cdsAmzRep.FieldByName('PRIIND').AsString  := qryTemp.FieldByName('PRIIND').AsString;
          cdsAmzRep.FieldByName('PRITIN').AsString  := qryTemp.FieldByName('PRITIN').AsString;

          cdsAmzRep.FieldByName('QTDREP').AsInteger :=
            fGetQtdItensRepAmz(qryTemp.FieldByName('CODAMZ').AsString);

          cdsAmzRep.Post();

          qryTemp.Next();
        End;

        dtsAmzRep.DataSet := cdsAmzRep;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmReplicacaoLotes.pInicializarClientDataSet]');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

end.
