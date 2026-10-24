unit untFatAltMecanico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass, cxProgressBar,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Grids,
  DBGridCitel, DBGrids, EditFocus, Uni, untZClient, Data.DB, StrUtils;

type
  THackDBGrid = class(TDBGridCitel);

  TfrmFatAltMecanico = class(TfrmPaiSimples)
    pnlTopo: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label4: TLabel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Bevel1: TBevel;
    Label2: TLabel;
    edtCliente: TEditFocus;
    Label3: TLabel;
    edtDtaEmi: TEditFocus;
    Label5: TLabel;
    edtCndPag: TEditFocus;
    Label6: TLabel;
    edtVendedor: TEditFocus;
    dbgItens: TDBGridCitel;
    pnlBotton: TPanel;
    dbgMec: TDBGridCitel;
    Splitter1: TSplitter;
    btnConfirma: TBitBtnLocked;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    intCorZeb : Integer;
    cdsMovDet : TZClient;
    cdsMecDet : TZClient;

    function fAbreDocumento : Boolean;
    function fGetSQLMovDet  : String;
    function fGetSQLMecDet  : String;

    procedure pCopiaMecanicos;
    procedure pInicializa;
    procedure pSetEnabled(blnEnabled : Boolean);
    procedure pInserirAlterarMecanico(blnAlterar : Boolean = False);
    procedure pCdsMovDetAfterScroll(DataSet : TDataSet);
    function fConfirma(cxProgressBar: TCxProgressBar): Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesAutocenter,
  untGravando;


function TfrmFatAltMecanico.fConfirma(cxProgressBar : TCxProgressBar):Boolean;
  Var
    strCodMec : String;
Begin
  Try
    cxProgressBar.Properties.Max := cdsMovDet.RecordCount;
    cxProgressBar.Position := 0;

    cdsMecDet.DisableControls;
    cdsMovDet.DisableControls;
    cdsMovDet.First;
    While Not cdsMovDet.Eof Do
    Begin
      strCodMec := '';

      cdsMecDet.Filtered := False;
      cdsMecDet.Filter := 'DET_SEQDET = ' + QuotedStr(cdsMovDet.FieldByName('AUTOINCREM').AsString) + ' AND TABELA = ' + QuotedStr(cdsMovDet.FieldByName('TABELA').AsString);
      cdsMecDet.Filtered := True;


      cdsMecDet.First;
      While not cdsMecDet.Eof Do
      Begin
        strCodMec := strCodMec + cdsMecDet.FieldByName('DET_CODMEC').AsString;
        cdsMecDet.Next;
        If Not cdsMecDet.Eof Then
          strCodMec := strCodMec + ',';
      End;

      if Pos('DET', cdsMovDet.FieldByName('TABELA').AsString) > 0 Then
      Begin
        pApagaMecanicosItem('MECDET', cdsMovDet.FieldByName('AUTOINCREM').AsString );
        pGravaMecanicosItem('MECDET', cdsMovDet.FieldByName('AUTOINCREM').AsString,
                                      cdsMovDet.FieldByName('DET_CODITE').AsString,

                                      cdsMovDet.FieldByName('DET_TOTITE').AsFloat -
                                      cdsMovDet.FieldByName('DET_DESESP').AsFloat -
                                      cdsMovDet.FieldByName('DET_SERRAT').AsFloat,

                                      strCodMec,
                                      cdsMovDet.FieldByName('DET_QTDITE').AsFloat);
      End
      Else
      Begin
        pApagaMecanicosServico( 'MECGER', cdsMovDet.FieldByName('AUTOINCREM').AsString,
                                          cdsMovDet.FieldByName('TABELA').AsString );

        pGravaMecanicosServico( 'MECGER', cdsMovDet.FieldByName('AUTOINCREM').AsString,
                                          cdsMovDet.FieldByName('TABELA').AsString,
                                          cdsMovDet.FieldByName('DET_CODITE').AsString,
                                          cdsMovDet.FieldByName('DET_TOTITE').AsFloat,
                                          strCodMec,
                                          cdsMovDet.FieldByName('DET_QTDITE').AsFloat);
      End;

      cdsMovDet.Next;
      cxProgressBar.Position := cxProgressBar.Position + 1;
    End;
    Result := True;
  Finally
    cdsMovDet.EnableControls;
    cdsMecDet.EnableControls;
  End;

End;

procedure TfrmFatAltMecanico.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not (cdsMovDet.Active And (cdsMovDet.RecordCount > 0 )) Then
    Exit;

  If fMensagem('', 'Confirma a Alteração de Mecânicos?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fConfirma;
  frmGravando.ShowModal;
  FreeAndNil(frmGravando);


  pInicializa;
end;

procedure TfrmFatAltMecanico.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDBGridCitel(Sender) Do
  Begin
    if (DataSource = Nil) Or (Not DataSource.DataSet.Active) Or (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    if Odd(DataSource.DataSet.RecNo) Then
    Begin
      Canvas.Brush.Color := intCorZeb;
      if ((gdFocused in State) or (gdSelected in state)) Then
        Canvas.Font.Color := clNavy;
    End;

    if ( TDBGridCitel(Sender).Tag = THackDBGrid(Sender).DataLink.ActiveRecord + 1) then
    begin
      Canvas.Brush.Color := clSilver;
      Canvas.Font.Color := clNavy;
    end;

    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);

  End;
end;

procedure TfrmFatAltMecanico.dbgItensMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  Var
    objCord: TGridCoord;
begin
  inherited;
  objCord := TDBGridCitel(Sender).MouseCoord(X,Y);
  TDBGridCitel(Sender).Tag := objCord.Y;
  TDBGridCitel(Sender).Repaint;

end;

procedure TfrmFatAltMecanico.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatAltMecanico.fAbreDocumento: Boolean;
  Var
    qryMovGer : TUniQuery;
    intIndex  : Integer;
    strCodSer : String;
begin
  qryMovGer := fCriaQuery(Self);
  With qryMovGer, SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT GER_CODCLI,                           ');
    Add('        CLI_NOMCLI,                           ');
    Add('        GER_DTAENT,                           ');
    Add('        GER_CONPAG,                           ');
    Add('        GER_CODVEN,                           ');
    Add('        OPE_NOMOPE,                           ');

    Add('        GER_CODS01,                           ');
    Add('        GER_CODS02,                           ');
    Add('        GER_CODS03,                           ');
    Add('        GER_CODS04,                           ');
    Add('        GER_CODS05,                           ');
    Add('        GER_CODS06,                           ');
    Add('        GER_CODS07,                           ');
    Add('        GER_CODS08,                           ');
    Add('        GER_CODS09,                           ');
    Add('        GER_CODS10,                           ');
    Add('        GER_CODS11,                           ');
    Add('        GER_CODS12,                           ');
    Add('        GER_CODS13,                           ');
    Add('        GER_CODS14,                           ');
    Add('        GER_CODS15,                           ');
    Add('        GER_CODS16,                           ');
    Add('        GER_CODS17,                           ');
    Add('        GER_CODS18,                           ');
    Add('        GER_CODS19,                           ');
    Add('        GER_CODS20,                           ');
    Add('        GER_CODS21,                           ');
    Add('        GER_CODS22,                           ');
    Add('        GER_CODS23,                           ');
    Add('        GER_CODS24,                           ');
    Add('        GER_CODS25,                           ');
    Add('        GER_CODS26,                           ');
    Add('        GER_CODS27,                           ');
    Add('        GER_CODS28,                           ');
    Add('        GER_CODS29,                           ');
    Add('        GER_CODS30,                           ');

    Add('        GER_DESS01,                           ');
    Add('        GER_DESS02,                           ');
    Add('        GER_DESS03,                           ');
    Add('        GER_DESS04,                           ');
    Add('        GER_DESS05,                           ');
    Add('        GER_DESS06,                           ');
    Add('        GER_DESS07,                           ');
    Add('        GER_DESS08,                           ');
    Add('        GER_DESS09,                           ');
    Add('        GER_DESS10,                           ');
    Add('        GER_DESS11,                           ');
    Add('        GER_DESS12,                           ');
    Add('        GER_DESS13,                           ');
    Add('        GER_DESS14,                           ');
    Add('        GER_DESS15,                           ');
    Add('        GER_DESS16,                           ');
    Add('        GER_DESS17,                           ');
    Add('        GER_DESS18,                           ');
    Add('        GER_DESS19,                           ');
    Add('        GER_DESS20,                           ');
    Add('        GER_DESS21,                           ');
    Add('        GER_DESS22,                           ');
    Add('        GER_DESS23,                           ');
    Add('        GER_DESS24,                           ');
    Add('        GER_DESS25,                           ');
    Add('        GER_DESS26,                           ');
    Add('        GER_DESS27,                           ');
    Add('        GER_DESS28,                           ');
    Add('        GER_DESS29,                           ');
    Add('        GER_DESS30,                           ');

    Add('        GER_QTDS01,                           ');
    Add('        GER_QTDS02,                           ');
    Add('        GER_QTDS03,                           ');
    Add('        GER_QTDS04,                           ');
    Add('        GER_QTDS05,                           ');
    Add('        GER_QTDS06,                           ');
    Add('        GER_QTDS07,                           ');
    Add('        GER_QTDS08,                           ');
    Add('        GER_QTDS09,                           ');
    Add('        GER_QTDS10,                           ');
    Add('        GER_QTDS11,                           ');
    Add('        GER_QTDS12,                           ');
    Add('        GER_QTDS13,                           ');
    Add('        GER_QTDS14,                           ');
    Add('        GER_QTDS15,                           ');
    Add('        GER_QTDS16,                           ');
    Add('        GER_QTDS17,                           ');
    Add('        GER_QTDS18,                           ');
    Add('        GER_QTDS19,                           ');
    Add('        GER_QTDS20,                           ');
    Add('        GER_QTDS21,                           ');
    Add('        GER_QTDS22,                           ');
    Add('        GER_QTDS23,                           ');
    Add('        GER_QTDS24,                           ');
    Add('        GER_QTDS25,                           ');
    Add('        GER_QTDS26,                           ');
    Add('        GER_QTDS27,                           ');
    Add('        GER_QTDS28,                           ');
    Add('        GER_QTDS29,                           ');
    Add('        GER_QTDS30,                           ');

    Add('        GER_VALS01,                           ');
    Add('        GER_VALS02,                           ');
    Add('        GER_VALS03,                           ');
    Add('        GER_VALS04,                           ');
    Add('        GER_VALS05,                           ');
    Add('        GER_VALS06,                           ');
    Add('        GER_VALS07,                           ');
    Add('        GER_VALS08,                           ');
    Add('        GER_VALS09,                           ');
    Add('        GER_VALS10,                           ');
    Add('        GER_VALS11,                           ');
    Add('        GER_VALS12,                           ');
    Add('        GER_VALS13,                           ');
    Add('        GER_VALS14,                           ');
    Add('        GER_VALS15,                           ');
    Add('        GER_VALS16,                           ');
    Add('        GER_VALS17,                           ');
    Add('        GER_VALS18,                           ');
    Add('        GER_VALS19,                           ');
    Add('        GER_VALS20,                           ');
    Add('        GER_VALS21,                           ');
    Add('        GER_VALS22,                           ');
    Add('        GER_VALS23,                           ');
    Add('        GER_VALS24,                           ');
    Add('        GER_VALS25,                           ');
    Add('        GER_VALS26,                           ');
    Add('        GER_VALS27,                           ');
    Add('        GER_VALS28,                           ');
    Add('        GER_VALS29,                           ');
    Add('        GER_VALS30,                           ');

    Add(' MOVGER.AUTOINCREM,                           ');
    Add(' "MOVGER" AS TABELA                           ');
    Add(' FROM MOVGER                                  ');
    Add(' LEFT  JOIN SERMOV ON GER_SEQGER = MOVGER.AUTOINCREM ');
    Add(' INNER JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ');
    Add(' INNER JOIN CADOPE ON OPE_CODOPE = GER_CODVEN ');
    Add(' WHERE GER_NUMDOC = :NUMDOC                   ');
    Add('   AND GER_ESPDOC = :ESPDOC                   ');
    Add('   AND GER_CODEMP = :CODEMP                   ');
    Add('   AND GER_TIP_FC = "C"                       ');
    Add('   AND LEFT(GER_CLAFIS,1) >= 5                ');

    ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    ParamByName('CODEMP').AsString := edtCodEmp.Text;

    Open;

    Result := Not IsEmpty;

    If Result Then
    Begin
      edtCliente.Text  := FieldByName('GER_CODCLI').AsString + ' - ' + FieldByName('CLI_NOMCLI').AsString;
      edtDtaEmi.Text   := FormatDateTime('dd/mm/yyyy', FieldByName('GER_DTAENT').AsDateTime);
      edtCndPag.Text   := fFormataCondPag(FieldByName('GER_CONPAG').AsString);
      edtVendedor.Text := FieldByName('GER_CODVEN').AsString + ' - ' + FieldByName('OPE_NOMOPE').AsString;

      cdsMovDet.Close;
      cdsMovDet.qryQuery.SQL.Clear;
      cdsMovDet.qryQuery.SQL.Add(fGetSQLMovDet);

      cdsMovDet.qryQuery.ParamByName('SEQGER').AsString := FieldByName('AUTOINCREM').AsString;
      cdsMovDet.qryQuery.ParamByName('ITESER').AsString := fCfgSis('ITESER');
      cdsMovDet.qryQuery.ParamByName('SERTER').AsString := fCfgSis('SERTER');

      cdsMovDet.fAbreClient(True, 'TfrmFatAltMecanico.fAbreDocumento');
      TFloatField(cdsMovDet.FieldByName('DET_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI'));

      For intIndex := 1 To 30 Do
      Begin

        strCodSer := FieldByName('GER_CODS' + fStrZero(intToStr(intIndex), 2) ).AsString;
        If not fEmptyStr( fRetNomeServico( strCodSer ) ) Then
        Begin
          cdsMovDet.Append;
          cdsMovDet.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
          cdsMovDet.FieldByName('DET_CODITE').AsString := strCodSer;
          cdsMovDet.FieldByName('DET_DESCRI').AsString := FieldByName('GER_DESS' + fStrZero(intToStr(intIndex), 2) ).AsString;
          cdsMovDet.FieldByName('UNI_SIGUNI').AsString := '';
          cdsMovDet.FieldByName('DET_QTDITE').AsFloat  := FieldByName('GER_QTDS' + fStrZero(intToStr(intIndex), 2) ).AsFloat;
          cdsMovDet.FieldByName('DET_TOTITE').AsFloat  := FieldByName('GER_VALS' + fStrZero(intToStr(intIndex), 2) ).AsFloat;
          cdsMovDet.FieldByName('DET_DESESP').AsFloat  := 0;
          cdsMovDet.FieldByName('DET_SERRAT').AsFloat  := 0;
          cdsMovDet.FieldByName('TABELA').AsString     := fStrZero(intToStr(intIndex), 2);
          cdsMovDet.Post;

        End;

      End;
      cdsMovDet.First;

      cdsMecDet.Close;
      If Not cdsMovDet.IsEmpty Then
      Begin
        cdsMecDet.qryQuery.SQL.Clear;
        cdsMecDet.qryQuery.SQL.Add(fGetSQLMecDet);
        cdsMecDet.qryQuery.ParamByName('SEQGER').AsString := FieldByName('AUTOINCREM').AsString;
        cdsMecDet.fAbreClient(True, 'TfrmFatAltMecanico.fAbreDocumento');
      End;

    End
    Else
    Begin
      edtCliente.Clear;
      edtDtaEmi.Clear;
      edtCndPag.Clear;
      edtVendedor.Clear;
      cdsMovDet.Close;
    End;

  End;

end;

function TfrmFatAltMecanico.fGetSQLMecDet: String;
begin
  Result := '';
  Result := Result + ' SELECT DET_SEQDET,                              ';
  Result := Result + '        DET_CODMEC,                              ';
  Result := Result + '        DET_PCOMEC,                              ';
  Result := Result + '        DET_VCOMEC,                              ';
  Result := Result + '        OPE_NOMOPE,                              ';
  Result := Result + ' "MOVDET" AS TABELA                              ';
  Result := Result + ' FROM MECDET                                     ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = DET_CODMEC    ';
  Result := Result + ' WHERE DET_SEQDET IN(SELECT AUTOINCREM           ';
  Result := Result + '                     FROM MOVDET                 ';
  Result := Result + '                     WHERE DET_SEQGER = :SEQGER) ';

  Result := Result + ' UNION ALL                                       ';

  Result := Result + ' SELECT GER_SEQGER,                              ';
  Result := Result + '        GER_CODMEC,                              ';
  Result := Result + '        GER_PCOMEC,                              ';
  Result := Result + '        GER_VCOMEC,                              ';
  Result := Result + '        OPE_NOMOPE,                              ';
  Result := Result + '        GER_IDESER                               ';
  Result := Result + ' FROM MECGER                                     ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = GER_CODMEC    ';
  Result := Result + ' WHERE GER_SEQGER = :SEQGER                      ';

  Result := Result + ' ORDER BY DET_SEQDET, DET_CODMEC                 ';
end;

function TfrmFatAltMecanico.fGetSQLMovDet: String;
begin
  Result := '';
  Result := Result + ' SELECT DET_CODITE,                           ';
  Result := Result + '        DET_DESCRI,                           ';
  Result := Result + '        UNI_SIGUNI,                           ';
  Result := Result + '        DET_QTDITE,                           ';
  Result := Result + '        DET_TOTITE,                           ';
  Result := Result + '        DET_DESESP,                           ';
  Result := Result + '        DET_SERRAT,                           ';
  Result := Result + ' "MOVDET" AS TABELA,                          ';
  Result := Result + ' MOVDET.AUTOINCREM                            ';
  Result := Result + ' FROM MOVDET                                  ';
  Result := Result + ' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result + ' INNER JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ';
  Result := Result + ' WHERE MOVDET.DET_SEQGER = :SEQGER            ';
  Result := Result + '   AND DET_CODITE <> :ITESER                  ';
  Result := Result + '   AND DET_CODITE <> :SERTER                  ';
  Result := Result + ' ORDER BY MOVDET.AUTOINCREM                   ';

end;

procedure TfrmFatAltMecanico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If cdsMovDet.Active Then
  Begin
    If (fMensagem('','Deseja cancelar a alteração?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      pInicializa;
    End;
    Action := caNone;
  End
end;

procedure TfrmFatAltMecanico.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMovDet := TZClient.Create(Self);
  dbgItens.DataSource   := cdsMovDet.dtsSource;
  cdsMovDet.AfterScroll := pCdsMovDetAfterScroll;

  cdsMecDet := TZClient.Create(Self);
  dbgMec.DataSource := cdsMecDet.dtsSource;

  intCorZeb := fCfgSis('CORZEB');

end;

procedure TfrmFatAltMecanico.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsMecDet);
  FreeAndNil(cdsMovDet);
  inherited;
end;

procedure TfrmFatAltMecanico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If ( Shift = [ssCtrl] ) Then
  Begin
    If Key = Ord('1') Then
      pSetFocus(dbgItens)
    Else
    If Key = Ord('2') Then
      pSetFocus(dbgMec)
    Else
    If Key = VK_Return Then
      If cdsMovDet.Active And (cdsMovDet.RecordCount > 0 ) Then
        pCopiaMecanicos;
  End
  Else

  if (Key = VK_DELETE) Then
  Begin
    if cdsMecDet.Active And (cdsMecDet.RecordCount > 0) And dbgMec.Focused And (fMensagem('', 'Deseja Excluir o Mecânico?', ['&Sim', '&Não'],2) = 1) Then
      cdsMecDet.Delete;
  End

  Else
  If (Key = VK_INSERT) Then
  Begin
    If cdsMovDet.Active And (cdsMovDet.RecordCount > 0 ) Then
      pInserirAlterarMecanico;
  End

  Else
  If (Key = VK_RETURN) Then
  Begin
    If cdsMecDet.Active And (cdsMecDet.RecordCount > 0) And dbgMec.Focused Then
      pInserirAlterarMecanico(True);
  End

  Else
  If (Key = VK_ESCAPE) Then
  Begin
    Close;
  End;

end;

function TfrmFatAltMecanico.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnValidaIndividual);
  If Result Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin
      edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
      If fEmptyStr(edtDesEmpresa.Text) Then
      Begin
        fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
        edtCodEmp.Clear;
        Result := False;
      End;

      If Result And (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

      If Result Then
      Begin
        Result := fAbreDocumento;

        If Result Then
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgItens);
          pSetEnabled(False);
        End
        Else
          fMensagem('','Documento não encontrado!', ['&OK']);

      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

End;

procedure TfrmFatAltMecanico.pInicializa;
begin
  cdsMovDet.Close;
  cdsMecDet.Close;

  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtCodEmp.Clear;
  edtDesEmpresa.Clear;
  edtCliente.Clear;
  edtDtaEmi.Clear;
  edtCndPag.Clear;
  edtVendedor.Clear;

  pSetEnabled(True);

  pSetFocus(edtNumDoc);
end;

procedure TfrmFatAltMecanico.pInserirAlterarMecanico(blnAlterar : Boolean = False);
  Var
    qryOperador : TUniQuery;
    Key : Char;
    arrSel : TConsultasArray;

  function fValida : Boolean;
  Begin
    If not blnAlterar Then
      Result := Not cdsMecDet.Locate('DET_CODMEC', qryOperador.FieldByName('OPE_CODOPE').AsString, [])
    Else
      Result := Not cdsMecDet.Locate('DET_SEQDET;DET_CODMEC', varArrayOf( [cdsMovDet.FieldByName('AUTOINCREM').AsString, qryOperador.FieldByName('OPE_CODOPE').AsString] ), []);
  End;

begin
  Try
    Key := '/';
    qryOperador := fCriaQuery(Self);
    if fPesqOperador(Self, Nil, Nil, qryOperador, Key, arrSel, True, False, False, True ) Then
    Begin
      if Not fValida Then
      Begin
        fMensagem('','Mecânico já informado!', ['&OK']);
        Exit;
      End;

      If fMecanicoInativo(qryOperador.FieldByName('OPE_CODOPE').AsString) then
      Begin
        fMensagem('', 'Este mecânico está inativo! Verifique o Cadastro de Operadores.', ['&Ok']);
        Exit;
      End;

      If blnAlterar Then
        cdsMecDet.Edit
      Else
        cdsMecDet.Append;

      cdsMecDet.FieldByName('DET_SEQDET').AsString := cdsMovDet.FieldByName('AUTOINCREM').AsString;
      cdsMecDet.FieldByName('TABELA').AsString     := cdsMovDet.FieldByName('TABELA').AsString;
      cdsMecDet.FieldByName('DET_CODMEC').AsString := qryOperador.FieldByName('OPE_CODOPE').AsString;
      cdsMecDet.FieldByName('OPE_NOMOPE').AsString := fRetNomeOperador(qryOperador.FieldByName('OPE_CODOPE').AsString);
      cdsMecDet.Post;
    End;

  Finally
    FreeAndNil(qryOperador);
  End;
end;

procedure TfrmFatAltMecanico.pCdsMovDetAfterScroll(DataSet: TDataSet);
begin
  cdsMecDet.Filtered := False;
  cdsMecDet.Filter := 'DET_SEQDET = ' + QuotedStr(cdsMovDet.FieldByName('AUTOINCREM').AsString) + ' AND TABELA = ' + QuotedStr(cdsMovDet.FieldByName('TABELA').AsString);
  cdsMecDet.Filtered := True;
end;

procedure TfrmFatAltMecanico.pCopiaMecanicos;
  Var
    cdsBackup: TZClient;
begin
  if fMensagem('','Deseja deixar todos os itens da venda igual o Produto/Serviço selecionado?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  Try
    cdsBackup := TZClient.Create(Self);

    cdsBackup.Data := cdsMecDet.Data;

    cdsBackup.First;
    While not cdsBackup.Eof Do
    Begin
      If (cdsBackup.FieldByName('DET_SEQDET').AsString + cdsBackup.FieldByName('TABELA').AsString) <>
         (cdsMovDet.FieldByName('AUTOINCREM').AsString + cdsMovDet.FieldByName('TABELA').AsString) Then
        cdsBackup.Delete
      Else
        cdsBackup.Next;
    End;

    cdsMovDet.DisableControls;
    cdsMecDet.DisableControls;

    cdsMecDet.Filtered := False;
    cdsMecDet.Filter := 'DET_SEQDET = ' + QuotedStr(cdsMovDet.FieldByName('AUTOINCREM').AsString) + ' AND TABELA = ' + QuotedStr(cdsMovDet.FieldByName('TABELA').AsString);
    cdsMecDet.Filtered := True;

    cdsMovDet.AfterScroll := Nil;

    cdsMecDet.EmptyDataSet;

    cdsMovDet.First;
    While Not cdsMovDet.Eof Do
    Begin

      cdsBackup.First;
      While not cdsBackup.Eof Do
      Begin

        cdsMecDet.Append;
        cdsMecDet.FieldByName('DET_SEQDET').AsString := cdsMovDet.FieldByName('AUTOINCREM').AsString;
        cdsMecDet.FieldByName('TABELA').AsString     := cdsMovDet.FieldByName('TABELA').AsString;
        cdsMecDet.FieldByName('DET_CODMEC').AsString := cdsBackup.FieldByName('DET_CODMEC').AsString;
        cdsMecDet.FieldByName('OPE_NOMOPE').AsString := fRetNomeOperador(cdsBackup.FieldByName('DET_CODMEC').AsString);
        cdsMecDet.Post;

        cdsBackup.Next;
      End;

      cdsMovDet.Next;
    End;

  Finally
    FreeAndNil(cdsBackup);
    cdsMovDet.AfterScroll := pCdsMovDetAfterScroll;
    cdsMovDet.EnableControls;
    cdsMecDet.EnableControls;
  End;

end;

procedure TfrmFatAltMecanico.pSetEnabled(blnEnabled: Boolean);
begin
  edtNumDoc.Enabled := blnEnabled;
  edtEspDoc.Enabled := blnEnabled;
  edtCodEmp.Enabled := blnEnabled;
end;

end.



