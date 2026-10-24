unit untValidarBaseItemAmarracao;

interface

Uses
  Uni, SysUtils, Data.DB;

Type
  TValidarBaseItemAmarracao = Class

  public
    constructor Create;
    destructor Destroy; override;

    {Funções Criadas para validação da amarração da base - Inicio}
    function fRetDesIte(strCodite : String) : String;
    function fRetNomeCampoDescricao(strIdePro : String) : String;
    function fRetNomeCampoPesoEspecifico(strIdePro : String) : String;
    {Funções Criadas para validação da amarração da base - Inicio}

    function fValidarBaseItemAmarracao(strIdePro : String; strCodBaseAtu : String; strDescBaseAtu : String ; strCodIte : String;
                                       strCoditeAnt : String; fltPesEsp : Double; fltEmbala : Double ) : Boolean;
  End;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncEspecificas;
{$ELSE}
  untFuncoesSimples, untLiberacaoCliente;
{$ENDIF}

{ TValidarBaseItemAmarracao }

constructor TValidarBaseItemAmarracao.Create;
begin

end;

destructor TValidarBaseItemAmarracao.Destroy;
begin

  inherited;
end;


function TValidarBaseItemAmarracao.fRetDesIte(strCodite : String) : String;
var
  qryGen     : TUniQuery;
begin
    qryGen := fCriaQuery();
    Try
      qryGen.SQL.Text := ' SELECT ITE_DESITE '+
                         '   FROM CADITE '+
                         '  WHERE ITE_CODITE = :CODITE';
      qryGen.ParamByName('CODITE').AsString := strCodite;
      qryGen.Open;

      Result := qryGen.Fields[0].AsString;

    Finally
      FreeAndNil(qryGen);
    End;

end;

function TValidarBaseItemAmarracao.fRetNomeCampoDescricao(strIdePro : String) : String;
begin
  Result := '';

  If Pos(strIdePro, 'DUP_DUX_WANPRO_BZC_LAZ_GLA_STA_DOX_NEX_PPG_PPX_BZA_SAL_STW_DU2_') > 0 Then
    Result := 'BAS_DESBAS'
  else
  If Pos(strIdePro, 'FAR_MZA_MZD_GEN_SKY_AJT_KIN_ROB_ALK_COA_MIF_LCA_PFA_ALA_BLA_') > 0 Then
  Begin
    Result  := 'BAS_DESCRI';
  end;
end;

function TValidarBaseItemAmarracao.fRetNomeCampoPesoEspecifico(strIdePro : String) : String;
begin
  Result := '';

  If Pos(strIdePro, 'DUP_DUX_WANPRO_STA_BZC_LAZ_SKY_GEN_DOX_MZA_MZD_NEX_PPX_PPG_AJT_STW_KIN_ROB_ALK_COA_DU2_MIF_LCA_PFA_ALA_BLA_') > 0 Then
    Result := 'BAS_PESESP'
  else
  If Pos(strIdePro, 'FAR_') > 0 Then
  Begin
    Result := 'BAS_DENSID'
  end
  Else
  If Pos(strIdePro, 'BZA_') > 0 Then
    Result := 'BAS_PESPEC'
  else
  If Pos(strIdePro, 'GLA_SAL_') > 0 Then
    Result := 'BAS_PESBAS';
end;

function TValidarBaseItemAmarracao.fValidarBaseItemAmarracao(strIdePro : String; strCodBaseAtu : String; strDescBaseAtu : String ; strCodIte : String;
                                   strCoditeAnt : String; fltPesEsp : Double; fltEmbala : Double ) : Boolean;
var
  qryGen      : TUniQuery;
  qryLogTin   : TUniQuery;
  blnTravar   : Boolean;
  strValAnt   : String;
  strValAtu   : String;
  strSQL      : String;
begin
  qryGen := Nil;

  Try
    VS_blnResult := true;
    strSQL := 'SELECT BAS_CODBAS  '+
              '     , '+ fRetNomeCampoDescricao(strIdePro) +' DESBAS  '+
              '     , '+ fRetNomeCampoPesoEspecifico(strIdePro) +' PESESP '+
              '     , '+ IIF(Pos(strIdePro, 'STA_') > 0,'BAS_VOLUME', 'BAS_EMBALA')+' BAS_EMBALA  '+
              '     , BAS_CODITE  '+
              '     , ITE_DESITE  '+
              '  FROM ' + strIdePro + '_CADBAS B '+
              ' INNER JOIN CADITE C ON C.ITE_CODITE = B.BAS_CODITE '+
              ' WHERE BAS_CODITE =  :CODITE ';


    // Verificar se houve alguma alteração
    qryGen := fCriaQuery();
    qryGen.SQL.Text := strSQL + '   AND BAS_CODBAS = :CODBAS ';

    qryGen.ParamByName('CODITE').AsString := strCodIte;
    qryGen.ParamByName('CODBAS').AsString := strCodBaseAtu;
    qryGen.Open;

    If ((qryGen.FieldByName('PESESP').AsFloat = fltPesEsp) And (qryGen.FieldByName('BAS_EMBALA').AsFloat = fltEmbala)) Then
    Begin
      Result := true;
      Exit;
    End;

    qryGen.SQL.Clear;
    qryGen.SQL.Text := strSQL + '   AND BAS_CODBAS <> :CODBAS ';
    qryGen.ParamByName('CODITE').AsString := strCodIte;
    qryGen.ParamByName('CODBAS').AsString := strCodBaseAtu;
    qryGen.Open;


    if Not(qryGen.IsEmpty) Then
    begin
      blnTravar := False;

      qryGen.First;

      While Not (qryGen.Eof) Do
      begin
        if (qryGen.FieldbyName('PESESP').AsFloat <> fltPesEsp)
         Or (qryGen.FieldbyName('BAS_EMBALA').AsFloat <> fltEmbala) Then
        Begin
          blnTravar := True;
        end;
        qryGen.Next;
      end;

      if (blnTravar) Then
      begin
       {$IFDEF LINUX}
        VS_blnResult := False;
       {$ELSE}
        frmLiberacaoCliente := TfrmLiberacaoCliente.Create(Nil);

        Try
          With frmLiberacaoCliente Do
          Begin
            MemObs.Lines.Add('------------------------------------------------------------------------------------------------------------------------');
            MemObs.Lines.Add(' Esse item já está relacionado a outra base e este procedimento ocasionará divergências de estoque no item utilizado.   ');
            MemObs.Lines.Add('                                                                                                                        ');
            MemObs.Lines.Add(' Este procedimento não é recomendado pela Citel.                                                                        ');
            MemObs.Lines.Add('------------------------------------------------------------------------------------------------------------------------');
            MemObs.Lines.Add(' Código do Item       : ' + strCodIte                                                                                    );
            MemObs.Lines.Add(' Descrição do Item    : ' + fRetDesIte(strCodIte)                                                                        );
            MemObs.Lines.Add('------------------------------------------------------------------------------------------------------------------------');
            MemObs.Lines.Add('                        Cód. | Descrição                                                                             ');
            MemObs.Lines.Add('------------------------------------------------------------------------------------------------------------------------');
            MemObs.Lines.Add(' Nova Amarração       : '+ strCodBaseAtu +' - '+ strDescBaseAtu                                                          );
            MemObs.Lines.Add('------------------------------------------------------------------------------------------------------------------------');

            qryGen.Close;
            qryGen.SQL.Text := qryGen.SQL.Text + ' AND (('+fRetNomeCampoPesoEspecifico(strIdePro)+' <> :PESESP) '+
                                                 '  OR ('+IIF(Pos(strIdePro, 'STA_') > 0,'BAS_VOLUME', 'BAS_EMBALA')+' <> :EMBALA)) ';

            qryGen.ParamByName('PESESP').AsFloat  := fltPesEsp;
            qryGen.ParamByName('EMBALA').AsFloat  := fltEmbala;
            qryGen.ParamByName('CODITE').AsString := strCodIte;
            qryGen.ParamByName('CODBAS').AsString := strCodBaseAtu;
            qryGen.Open;

            qryGen.First;

            While Not (qryGen.Eof) Do
            Begin
              If (qryGen.RecNo = 1) Then
                MemObs.Lines.Add(' Amarrações Exitentes : ' + qryGen.FieldbyName('BAS_CODBAS').AsString +' - '+ qryGen.FieldbyName('DESBAS').AsString )
              else
                MemObs.Lines.Add('                      : ' + qryGen.FieldbyName('BAS_CODBAS').AsString +' - '+ qryGen.FieldbyName('DESBAS').AsString );

              qryGen.Next;
            End;

            MemObs.Lines.Add('------------------------------------------------------------------------------------------------------------------------');

            ShowModal;

            if (VS_blnResult) Then
            begin
              qryLogTin := fCriaQuery();

              Try
                qryLogTin.Close;
                qryLogTin.SQl.Text := 'SELECT * FROM LOGTIN WHERE FALSE';
                qryLogTin.Open;

                strValAnt := 'Cod.Base:' +strCodBaseAtu+ ' | Descr.Base: ' + strDescBaseAtu  + ' | Cód.Item:'+ StrCodIteAnt +' | Descr.Item:' + fRetDesIte(strCoditeAnt);
                strValAtu := 'Cod.Base:' +strCodBaseAtu+ ' | Descr.Base: ' + strDescBaseAtu  + ' | Cód.Item:'+ strCodIte +' | Descr.Item:' + fRetDesIte(strCodIte);

                qryLogTin.Insert;
                qryLogTin.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGTIN', VS_strCodEmp);
                qryLogTin.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
                qryLogTin.FieldByName('LOG_HORALT').AsDateTime := fTime();
                qryLogTin.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
                qryLogTin.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
                qryLogTin.FieldByName('LOG_EMPCFG').AsString   := VS_strCodEmp;
                qryLogTin.FieldByName('LOG_CODCFG').AsString   := 'BASITE';
                qryLogTin.FieldByName('LOG_IDEPRO').AsString   := strIdePro;
                qryLogTin.FieldByName('LOG_VALANT').AsString   := strValAnt;
                qryLogTin.FieldByName('LOG_VALATU').AsString   := strValAtu;
                qryLogTin.Post;
              Finally
                FreeAndNil(qryLogTin);
              end;
            end;
          End;
        Finally
          If Assigned(frmLiberacaoCliente) Then
            FreeAndNil(frmLiberacaoCliente);
        End;
       {$ENDIF}
      end
      Else
      Begin
        VS_blnResult := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
      End;
    end;

  Finally
    Result := VS_blnResult;
    FreeAndNil(qryGen);
  End;


end;

end.
